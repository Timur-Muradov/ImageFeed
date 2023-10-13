//
//  ProfileViewController.swift
//  ImageFeed
//
//  Created by Тимур Мурадов on 16.05.2023.
//
import UIKit
import Kingfisher

public protocol ProfileViewControllerProtocol: AnyObject {
    var presenter: ProfileViewPresenterProtocol? { get set }
    func updateProfileDetales(name: String, login: String, bio: String)
    func setupAvatar(url: URL)
}

class ProfileViewController: UIViewController, ProfileViewControllerProtocol {
    
    var presenter: ProfileViewPresenterProtocol? = {
        return ProfileViewPresenter() }()
    
    private let profileService = ProfileService.shared
    override var preferredStatusBarStyle: UIStatusBarStyle { .lightContent }
    private let placeholder = UIImage(named: ProfileViewConstants.profilePlaceholder)
    private var profileImageServiceObserver: NSObjectProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .ypBlack
        presenter?.view = self
        presenter?.updateProfileDetails()
        
        setupLayout()
        profileImageServiceObserver = NotificationCenter.default
            .addObserver(forName: ProfileImageService.didChangeNotification,
                         object: nil,
                         queue: .main
            ) { [weak self] _ in
                guard let self else { return }
                self.presenter?.updateAvatar()
            }
    }
    
    func setupLayout() {
        
        NSLayoutConstraint.activate([
            
            imageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            imageView.widthAnchor.constraint(equalToConstant: 70),
            imageView.heightAnchor.constraint(equalToConstant: 70),
            
            
            labelName.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            labelName.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            
            nickName.leadingAnchor.constraint(equalTo: labelName.leadingAnchor),
            nickName.topAnchor.constraint(equalTo: labelName.bottomAnchor, constant: 8),
            
            discription.leadingAnchor.constraint(equalTo: nickName.leadingAnchor),
            discription.topAnchor.constraint(equalTo: nickName.bottomAnchor, constant: 8),
            
            escButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            escButton.centerYAnchor.constraint(equalTo: imageView.centerYAnchor)
        ])
        
    }
    
    func updateProfileDetales(name: String, login: String, bio: String) {
        //guard let profile = profile else { return }
        labelName.text = name
        nickName.text = login
        discription.text = bio
    }
    
    
    func setupAvatar(url: URL) {
        //        guard
        //            let profileImageURL = ProfileImageService.shared.avatarURL,
        //            let url = URL(string: profileImageURL)
        //        else { return }
        let cache = ImageCache.default
        cache.clearMemoryCache()
        cache.clearDiskCache()
        
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(with: url, placeholder: placeholder) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let image):
                self.imageView.image = image.image
            case .failure:
                self.imageView.image = self.placeholder
            }
        }
    }
    
    private lazy var imageView: UIImageView = {
        
        let profileImage = UIImage(named: ProfileViewConstants.profileImage)
        let imageView = UIImageView(image: profileImage)
        imageView.layer.cornerRadius = 35
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        return imageView
        
    }()
    
    private lazy var labelName: UILabel = {
        
        let labelName = UILabel()
        labelName.text = ProfileViewConstants.profilelabelName
        labelName.textColor = .ypWhite
        labelName.font = UIFont.systemFont(ofSize: 23)
        view.addSubview(labelName)
        labelName.translatesAutoresizingMaskIntoConstraints = false
        return labelName
        
    }()
    
    private lazy var nickName: UILabel = {
        
        let nickName = UILabel()
        nickName.text = ProfileViewConstants.profileNickName
        nickName.textColor = .ypGray
        nickName.font = UIFont.systemFont(ofSize: 13)
        view.addSubview(nickName)
        nickName.translatesAutoresizingMaskIntoConstraints = false
        return nickName
        
    }()
    
    private lazy var discription: UILabel = {
        
        let discription = UILabel()
        discription.text = ProfileViewConstants.profileDiscription
        discription.textColor = .ypWhite
        discription.font = UIFont.systemFont(ofSize: 13)
        view.addSubview(discription)
        discription.translatesAutoresizingMaskIntoConstraints = false
        return discription
        
    }()
    
    private lazy var escButton: UIButton = {
        
        let button = UIButton.systemButton(
            with: UIImage(systemName: ProfileViewConstants.profileEscButton)!,
            target: self,
            action: #selector(Self.didTapButton)
        )
        button.accessibilityIdentifier = "escButton"
        button.tintColor = .ypRed
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        return button
        
    }()
    
    @objc
    private func didTapButton() {
        byebyeAlert(title: ProfileViewConstants.profileDidTapButtonTitle,
                    message: ProfileViewConstants.profiledidTapButtonMessage) {
            self.logout()
        }
    }
    
    func logout() {
        OAuth2TokenStorage.shared.clean()
        WebViewViewController.clean()
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            let window = windowScene.windows.first
            
            window?.rootViewController = SplashViewController()
            window?.makeKeyAndVisible()
        }
    }
    
    private func byebyeAlert(title: String, message: String, handler: @escaping () -> Void) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        let yesAction = UIAlertAction(title: ProfileViewConstants.byeByeAlertTitleYesAction,
                                      style: .default) { _ in
            handler()
        }
        let noAction = UIAlertAction(title: ProfileViewConstants.byeByeAlertTitleNoAction,
                                     style: .default) { _ in }
        
        alert.addAction(yesAction)
        alert.addAction(noAction)
        present(alert, animated: true)
    }
}
