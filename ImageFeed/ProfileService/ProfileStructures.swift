//
//  ProfileStructures.swift
//  ImageFeed
//
//  Created by Тимур Мурадов on 28.06.2023.
//

import Foundation

struct ProfileResult: Codable {
    let username: String
    let firstName: String?
    let lastName: String?
    let bio: String?
    let profileImage: ProfileImage?
}

struct ProfileImage: Codable {
    let small: String?
    let medium: String?
    let large: String?
}

struct Profile: Codable {
    let username: String?
    let name: String?
    let loginName: String
    let bio: String?
    init (ProfileResult: ProfileResult) {
        self.username = ProfileResult.username
        self.name = (ProfileResult.firstName ?? "") + " " + (ProfileResult.lastName ?? "")
        self.loginName = "@" + (ProfileResult.username )
        self.bio = ProfileResult.bio
    }
}

//extension Profile {
//    init (result profile: ProfileResult) {
//        self.init(
//            username: profile.username,
//            name: "\(profile.firstName ?? "") \(profile.lastName ?? "")",
//            loginName: "@\(profile.username)",
//            bio: profile.bio)
//    }
//}
