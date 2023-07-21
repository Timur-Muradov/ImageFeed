//
//  Constants.swift
//  ImageFeed
//
//  Created by Тимур Мурадов on 01.06.2023.
//

import UIKit
enum Constants {
    
    // MARK: Unsplash api base paths
    static let defaultApiBaseURLString = "https://api.unsplash.com"
    static let baseURLString = "https://unsplash.com"
    static let unsplashAuthorizeURLString = "https://unsplash.com/oauth/authorize"
    static let baseAuthTokenPath = "/oauth/token"
    
    // MARK: Unsplash api constants
    static let AccessKey = "wWNF9BTEp4WGxkinrc3NXxKNKGX4p6FM-1bNagbzQcU"
    static let SecretKey = "WyCn9pnRtBkzkO_ijiQzUw1ZJ2f-kQ-oMTlHw-vnskk"
    static let RedirectURI = "urn:ietf:wg:oauth:2.0:oob"
    static let AccessScope = "public+read_user+write_likes"
    static let DefaultBaseURL = URL(string: "https://api.unsplash.com")!
    
    
    // MARK: Storage constants
    static let bearerToken = "bearerToken"
    
}
