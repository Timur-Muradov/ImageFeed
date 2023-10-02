//
//  ImageListServiceProtocol.swift
//  ImageFeed
//
//  Created by Тимур Мурадов on 28.09.2023.
//

import Foundation

protocol ImageListServiceProtocol {
    var photos: [Photo] { get }
    func fetchPhotoNextPage()
    func fetchImagesRequest(page: Int) -> URLRequest?
    func changeLike(photoId: String,
                    isLike: Bool,
                    completion: @escaping (Result<Void, Error>) -> Void)
}
