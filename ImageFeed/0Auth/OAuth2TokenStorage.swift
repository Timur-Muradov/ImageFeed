//
//  OAuth2TokenStorage.swift
//  ImageFeed
//
//  Created by Тимур Мурадов on 08.06.2023.
//

import UIKit
import SwiftKeychainWrapper

final class OAuth2TokenStorage: UIViewController {
    
    static let shared = OAuth2TokenStorage()
    private let bearerTokenKey = "OAuth2TokenStorage"
    private let keychainWrapper = KeychainWrapper.standard
    
    var token: String? {
        get{
            return keychainWrapper.string(forKey: bearerTokenKey)
        }
        set{
            guard let newValue = newValue else { return }
            keychainWrapper.set(newValue, forKey: bearerTokenKey)
        }
    }
    
}
