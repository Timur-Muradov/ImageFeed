//
//  TabBarController.swift
//  ImageFeed
//
//  Created by Тимур Мурадов on 18.07.2023.
//

import Foundation
import UIKit
 
final class TabBarController: UITabBarController {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        
        let imagesListViewController: ImagesListViewControllerProtocol = storyboard.instantiateViewController(
            withIdentifier: "ImagesListViewController") as! ImagesListViewControllerProtocol
        let presenter = ImagesListPresenter(view: imagesListViewController)
        imagesListViewController.presenter = presenter
        let profileViewController = ProfileViewController()
        profileViewController.tabBarItem = UITabBarItem(
                    title: nil,
                    image: UIImage(named: "tab_profile_active"),
                    selectedImage: nil)
        
        imagesListViewController.tabBarItem = UITabBarItem(
                    title: nil,
                    image: UIImage(named: "tab_editorial_active"),
                    selectedImage: nil
                )
        
        self.viewControllers = [imagesListViewController, profileViewController]
    }
    
}
