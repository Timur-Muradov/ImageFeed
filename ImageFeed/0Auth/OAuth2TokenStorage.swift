//
//  OAuth2TokenStorage.swift
//  ImageFeed
//
//  Created by Тимур Мурадов on 08.06.2023.
//

import UIKit

final class OAuth2TokenStorage: UIViewController {
    
    static let shared = OAuth2TokenStorage()
    private let bearerTokenKey = "OAuth2TokenStorage"
    
    var token: String? {
        get{
            return UserDefaults.standard.string(forKey: bearerTokenKey)
        }
        set{
            UserDefaults.standard.set(newValue, forKey: bearerTokenKey)
        }
    }
    
}
