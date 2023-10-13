//
//  ImagesListConstants.swift
//  ImageFeed
//
//  Created by Тимур Мурадов on 28.09.2023.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case delete = "DELETE"
    case post = "POST"
}

enum URLParameters {
    case photosPage(number: Int)
    var rawValue: String {
        switch self {
        case .photosPage(let number):
            return "/photos?page=\(number)&per_page=10"
        }
    }
}

struct ContentInset {
    static let table = 12.0
    static let imageHorizontal = 16.0
    static let imageVertical = 4.0
}

struct NotificationNames {
    static let didChange = Notification.Name(rawValue: "ImagesListServiceDidChange")
}

enum ImagesMessage: String {
    case empty = ""
    case likeButtonOn = "like_button_on"
    case likeButtonOff = "like_button_off"
    case updateCellDateFormat = "d MMMM yyyy"
    case imagePlaceholder = "image_stub"
    case likeAlertActionTitle = "Okay"
    case likeAlertMessage = "Не удалось поставить лайк"
    case likeAllertSomethingWrong = "Что-то пошло не так("
    case likeIsEmpty = "Like's empty"
    case failToFetchPhotos = "Fail to fetch photos "
    case fetchAssertionFailure = "Invalid Request"
    case imagesListCellIdentifire = "ImagesListCell"
    case singleImageViewControllerIdentifier = "ShowSingleImage"
}
