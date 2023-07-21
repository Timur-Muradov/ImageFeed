//
//  OAuthTokenResponseBody.swift
//  ImageFeed
//
//  Created by Тимур Мурадов on 17.07.2023.
//

import Foundation

 struct OAuthTokenResponseBody: Decodable {
        
    let accessToken: String
    let tokenType: String
    let scope: String
    let createdAt: Int
    
   private enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
        case scope
        case createdAt = "created_at"
    }
    
    let url = URL(string: "https://unsplash.com/oauth/token")!
}
