//
//  SplashViewController.swift
//  ImageFeed
//
//  Created by Тимур Мурадов on 13.06.2023.
//

import UIKit
import ProgressHUD

final class SplashViewController: UIViewController {
    
    private let ShowAuthenticationScreenSegueIdentifier = "ShowAuthenticationScreen"
    private let oauth2Service = OAuth2Service()
    private let oauth2TokenStorage = OAuth2TokenStorage()
    private let profileService = ProfileService.shared
    private let authToken = OAuth2TokenStorage.shared
    private let showLoginFlowSegueIdentifier = "ShowLoginFlow"
    private let alertPresenter = AlertPresenter()
    private let profileImageService = ProfileImageService.shared
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .ypBlack
        alertPresenter.delegate = self
        setupImage()
    }
    
    func setupImage() {
        
        let image = UIImage(named: "Vector")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            
        ])
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let token = oauth2TokenStorage.token {
            UIBlockingProgressHUD.show()
            self.fetchProfile(token: token)
        } else {
            if let authController = UIStoryboard(name: "Main", bundle: .main)
                .instantiateViewController (withIdentifier: "AuthViewController") as? AuthViewController {
                authController.delegate = self
                authController.modalPresentationStyle = .fullScreen
                present (authController, animated: true)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    private func switchToTabBarController() {
        guard let window = UIApplication.shared.windows.first else { fatalError("Invalid Configuration") }
        let tabBarController = UIStoryboard(name: "Main", bundle: .main)
            .instantiateViewController(withIdentifier: "TabBarViewController")
        window.rootViewController = tabBarController
    }
}

extension SplashViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == ShowAuthenticationScreenSegueIdentifier {
            guard
                let navigationController = segue.destination as? UINavigationController,
                let viewController = navigationController.viewControllers[0] as? AuthViewController
            else { fatalError("Failed to prepare for \(ShowAuthenticationScreenSegueIdentifier)") }
            viewController.delegate = self
        } else {
            super.prepare(for: segue, sender: sender)
        }
    }
}

extension SplashViewController: AuthViewControllerDelegate {
    func authViewController(_ vc: AuthViewController, didAuthenticateWithCode code: String) {
        
        ProgressHUD.show()
        dismiss(animated: true) { [weak self] in
            guard let self = self else { return }
            self.fetchOAuthToken(code)
            
        }
    }
    
    private func fetchOAuthToken(_ code: String) {
        UIBlockingProgressHUD.show()
        oauth2Service.fetchOAuthToken(code) { [weak self] authResult in
            guard let self = self else { return }
            switch authResult {
            case .success(let token):
                self.fetchProfile(token: token)
            case .failure(let error):
                self.showLoginAlert(error: error)
            }
            UIBlockingProgressHUD.dismiss()
        }
    }
    
    private func fetchProfile(token: String) {
        profileService.fetchProfile(token) { [weak self] profileResult in
            guard let self = self else { return }
            switch profileResult {
            case .success(_):
                guard let user = self.profileService.profile?.username
                else { return }
                self.profileImageService.fetchProfileImageURL(userName: user) { _ in }
                self.switchToTabBarController()
            case .failure(let error):
                self.showLoginAlert(error: error)
            }
            UIBlockingProgressHUD.dismiss()
        }
    }
    
    
    private func presentAuthController() {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        guard let authViewController = storyboard
            .instantiateViewController(withIdentifier: "AuthViewController") as? AuthViewController else { return }
        authViewController.delegate = self
        authViewController.modalPresentationStyle = .fullScreen
        present(authViewController, animated: true)
    }
    
    private func showLoginAlert(error: Error) {
        alertPresenter.showAlert(title: "Что-то пошло не так",
                                 message: "Не удалось войти в систему, \(error.localizedDescription)") {
            self.performSegue(withIdentifier: self.showLoginFlowSegueIdentifier, sender: nil)
        }
    }
}
