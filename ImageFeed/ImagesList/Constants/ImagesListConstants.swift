//
//  ImageListConstants.swift
//  ImageFeed
//
//  Created by Тимур Мурадов on 28.09.2023.
//

import Foundation

struct ImagesListConstants {
    
    enum Strings: String {
        case empty = ""
        case setIsLikeButtonIsOn = "like_button_on"
        case setIsLikeButtonIsOff = "like_button_off"
        case updateCellDateFormat = "d MMMM yyyy"
        case placeholder = "image_stub"
        case likeIsOkay = "Okay"
        case likeAlertNoLike = "Не удалось поставить лайк"
        case likeAllertSomethingWrong = "Что-то пошло не так("
        case likeIsEmpty = "Like's empty"
        case failToFetchPhotos = "Fail to fetch photos "
        case fetchAssertionFailure = "Invalid Request"
        case imagesListCellIdentifire = "ImagesListCell"
        case singleImageViewControllerIdentifier = "ShowSingleImage"
    }
    
    enum HttpMethods: String {
        case get = "GET"
        case delete = "DELETE"
        case post = "POST"
    }
    
    enum UrlParameters {
        case photosPage(number: Int)
        var rawValue: String {
            switch self {
            case .photosPage(let number):
                return "/photos?page=\(number)&per_page=10"
            }
        }
    }
    
    static let tableContentInset = 12.0
    static let imageHorizontalInset = 16.0
    static let imageVerticalInset = 4.0
    static let didChangeNotification = Notification.Name(rawValue: "ImagesListServiceDidChange")
}
