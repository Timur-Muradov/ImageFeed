//
//  ProfileViewController.swift
//  ImageFeed
//
//  Created by Тимур Мурадов on 16.05.2023.
//

import Foundation
import UIKit

class ProfileViewController: UIViewController {
     
    @IBOutlet private var avatarImageView: UIImageView!
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var loginNameLabel: UILabel!
    @IBOutlet private var descriptionLabel: UILabel!

    @IBOutlet private var logoutButton: UIButton!
    @IBAction private func didTapLogoutButton() {
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}
