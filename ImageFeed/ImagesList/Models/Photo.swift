//
//  Photo.swift
//  ImageFeed
//
//  Created by Тимур Мурадов on 28.09.2023.
//

import Foundation

struct Photo: Codable {
    let id: String
    let size: CGSize
    let createdAt: Date?
    let welcomeDescription: String?
    let thumbImageURL: String
    let largeImageURL: String
    let isLiked: Bool
    
    init(photoResult: PhotoResult, dateFormat: ISO8601DateFormatter) {
        self.id = photoResult.id
        self.size = CGSize(width: photoResult.width, height: photoResult.height)
        self.createdAt = dateFormat.date(from: photoResult.createdAt ?? "")
        self.welcomeDescription = photoResult.description ?? ""
        self.thumbImageURL = photoResult.urls.thumb
        self.largeImageURL = photoResult.urls.full
        self.isLiked = photoResult.likedByUser
    }
}
