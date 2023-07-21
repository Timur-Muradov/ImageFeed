//
//  ProfileViewController.swift
//  ImageFeed
//
//  Created by Тимур Мурадов on 16.05.2023.
//
import UIKit
import Kingfisher

class ProfileViewController: UIViewController {
    
    private let profileService = ProfileService.shared
    override var preferredStatusBarStyle: UIStatusBarStyle { .lightContent }
    private let placeholder = UIImage(named: "placeholder")
    private var profileImageServiceObserver: NSObjectProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .ypBlack
        profileImageServiceObserver = NotificationCenter.default.addObserver(
            forName: ProfileImageService.didChangeNotification,
            object: nil,
            queue: .main
        ){ [ weak self ] notification in
            guard let self = self else { return }
            self.updateAvatar()
        }
        updateAvatar()
        updateProfileDetales(profile: profileService.profile)
        setupLayout()
        
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
    
    func updateProfileDetales(profile: Profile?) {
        guard let profile = profile else { return }
        
        labelName.text = profile.name
        nickName.text = profile.loginName
        discription.text = profile.bio
    }
    
    
    private func updateAvatar() {
        guard
            let profileImageURL = ProfileImageService.shared.avatarURL,
            let url = URL(string: profileImageURL)
        else { return }
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
        
        let profileImage = UIImage(named: "Photo")
        let imageView = UIImageView(image: profileImage)
        imageView.layer.cornerRadius = 35
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        return imageView
        
    }()
    
    private lazy var labelName: UILabel = {
        
        let labelName = UILabel()
        labelName.text = "Екатерина Новикова"
        labelName.textColor = .ypWhite
        labelName.font = UIFont.systemFont(ofSize: 23)
        view.addSubview(labelName)
        labelName.translatesAutoresizingMaskIntoConstraints = false
        return labelName
        
    }()
    
    private lazy var nickName: UILabel = {
        
        let nickName = UILabel()
        nickName.text = "@ekaterina_nov"
        nickName.textColor = .ypGray
        nickName.font = UIFont.systemFont(ofSize: 13)
        view.addSubview(nickName)
        nickName.translatesAutoresizingMaskIntoConstraints = false
        return nickName
        
    }()
    
    private lazy var discription: UILabel = {
        
        let discription = UILabel()
        discription.text = "Hello World"
        discription.textColor = .ypWhite
        discription.font = UIFont.systemFont(ofSize: 13)
        view.addSubview(discription)
        discription.translatesAutoresizingMaskIntoConstraints = false
        return discription
        
    }()
    
    private lazy var escButton: UIButton = {
        
        let button = UIButton.systemButton(
            with: UIImage(systemName: "ipad.and.arrow.forward")!,
            target: self,
            action: #selector(Self.didTapButton)
        )
        button.tintColor = .ypRed
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        return button
        
    }()
    
    @objc
    private func didTapButton() {
        print("Здравствуй, многоуважаемый ревьюер :)")
        
    }
}
