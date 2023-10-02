//
//  Constants.swift
//  ImageFeed
//
//  Created by Тимур Мурадов on 01.06.2023.
//

import UIKit
import Foundation

// MARK: Unsplash api base paths
let defaultApiBaseURLString = "https://api.unsplash.com"
let baseURLString = "https://api.unsplash.com"
let unsplashAuthorizeURLString = "https://unsplash.com/oauth/authorize"
let baseAuthTokenPath = "/oauth/token"

// MARK: Unsplash api constants
let AccessKey = "wWNF9BTEp4WGxkinrc3NXxKNKGX4p6FM-1bNagbzQcU"
let SecretKey = "WyCn9pnRtBkzkO_ijiQzUw1ZJ2f-kQ-oMTlHw-vnskk"
let RedirectURI = "urn:ietf:wg:oauth:2.0:oob"
let AccessScope = "public+read_user+write_likes"
let DefaultBaseURL = URL(string: "https://api.unsplash.com")!

// MARK: Storage constants
let bearerToken = "bearerToken"

struct AuthConfiguration {
    let accessKey: String
    let secretKey: String
    let redirectURI: String
    let accessScope: String
    let defaultBaseURL: URL
    let authURLString: String
    static var standard: AuthConfiguration {
        return AuthConfiguration(accessKey: AccessKey,
                                 secretKey: SecretKey,
                                 redirectURI: RedirectURI,
                                 accessScope: AccessScope,
                                 authURLString: unsplashAuthorizeURLString,
                                 defaultBaseURL: DefaultBaseURL)
    }
    
    init(accessKey: String, secretKey: String, redirectURI: String, accessScope: String, authURLString: String, defaultBaseURL: URL) {
        self.accessKey = accessKey
        self.secretKey = secretKey
        self.redirectURI = redirectURI
        self.accessScope = accessScope
        self.defaultBaseURL = defaultBaseURL
        self.authURLString = authURLString
    }
}
