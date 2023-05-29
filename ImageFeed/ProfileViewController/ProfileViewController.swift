//
//  ProfileViewController.swift
//  ImageFeed
//
//  Created by Тимур Мурадов on 16.05.2023.
//

import Foundation
import UIKit

class ProfileViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imageView = photofunc()
        let labelName = namefunc()
        let nickName = nNamefunc()
        let discription = discfunc()
        let button = escButton()
        
        
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
            
            button.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            button.centerYAnchor.constraint(equalTo: imageView.centerYAnchor)
            
        ])
        
    }
    
    func photofunc() -> UIImageView {
        
        let profileImage = UIImage(named: "Photo")
        let imageView = UIImageView(image: profileImage)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        return imageView
        
    }
    
    func namefunc() -> UILabel {
        
        let labelName = UILabel()
        labelName.text = "Екатерина Новикова"
        labelName.textColor = .ypWhite
        labelName.font = UIFont.systemFont(ofSize: 23)
        view.addSubview(labelName)
        labelName.translatesAutoresizingMaskIntoConstraints = false
        return labelName
        
    }
    
    func nNamefunc() -> UILabel {
        
        let nickName = UILabel()
        nickName.text = "@ekaterina_nov"
        nickName.textColor = .ypGray
        nickName.font = UIFont.systemFont(ofSize: 13)
        view.addSubview(nickName)
        nickName.translatesAutoresizingMaskIntoConstraints = false
        return nickName
        
    }
    
    func discfunc() -> UILabel {
        
        let discription = UILabel()
        discription.text = "Hello World"
        discription.textColor = .ypWhite
        discription.font = UIFont.systemFont(ofSize: 13)
        view.addSubview(discription)
        discription.translatesAutoresizingMaskIntoConstraints = false
        return discription
        
    }
    
    func escButton() -> UIButton {
        
        let button = UIButton.systemButton(
            with: UIImage(systemName: "ipad.and.arrow.forward")!,
            target: self,
            action: #selector(Self.didTapButton)
        )
        button.tintColor = .red
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        return button
        
    }
    
    @objc
    private func didTapButton() {
        print("Здравствуй, многоуважаемый ревьюер :)")
        
    }
}
