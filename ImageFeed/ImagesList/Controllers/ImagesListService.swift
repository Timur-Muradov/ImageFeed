//
//  ImagesListService.swift
//  ImageFeed
//
//  Created by Тимур Мурадов on 24.07.2023.
//

import Foundation
import UIKit

final class ImagesListService: ImagesListServiceProtocol {
    static let shared = ImagesListService()
    private(set) var photos: [Photo] = []
    private(set) var lastPhotosCount: Int = 0
    private var lastLoadedPage: Int?
    private var currentTask: URLSessionTask?
    private let dateFormat = ISO8601DateFormatter()
    private let builder: URLRequestBuilder
    
    init(builder: URLRequestBuilder = .shared) {
        self.builder = builder
    }
    
    func fetchPhotoNextPage() {
        assert(Thread.isMainThread)
        if let currentTask = currentTask, currentTask.state == .running {
            return
        }
        lastPhotosCount = photos.count
        let nextPage = lastLoadedPage == nil ? 1 : (lastLoadedPage! + 1)
        guard let request = fetchImagesRequest(page: nextPage) else {
            assertionFailure(ImagesMessage.fetchAssertionFailure.rawValue)
            return
        }
        
        let session = URLSession.shared
        let task = session.objectTask(for: request) { [weak self] (response: Result<[PhotoResult], Error>) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch response {
                case .success(let newPhotoResult):
                    if self.lastLoadedPage == nil {
                        self.lastLoadedPage = 1
                    } else {
                        self.lastLoadedPage! += 1
                    }
                    let newPhoto = newPhotoResult.map { Photo(photoResult: $0, dateFormat: self.dateFormat) }
                    self.photos.append(contentsOf: newPhoto)
                    
                    NotificationCenter.default.post(name: NotificationNames.didChange, object: nil)
                    
                case .failure(let error):
                    print(ImagesMessage.failToFetchPhotos.rawValue + "\(error)")
                    
                }
            }
        }
        self.currentTask = task
        task.resume()
    }
    
    func fetchImagesRequest(page: Int) -> URLRequest? {
        return builder.makeHTTPRequest(
            path: URLParameters.photosPage(number: page).rawValue,
            httpMethod: HTTPMethod.get.rawValue,
            baseURL: baseURLString
        )
    }
    
    func changeLike(photoId: String, isLike: Bool, completion: @escaping (Result<Void, Error>) -> Void) {
        assert(Thread.isMainThread)
        if currentTask != nil {
            currentTask?.cancel()
        }
        
        guard let request = makeLikeRequest(isLike: isLike, photoId: photoId) else {
            assertionFailure(ImagesMessage.likeIsEmpty.rawValue)
            return
        }
        
        let session = URLSession.shared
        let task = session.objectTask(for: request) { [weak self] (response: Result<LikedPhoto, Error>) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch response {
                case .success:
                    if let index = self.photos.firstIndex(where: { $0.id == photoId }) {
                        let photo = self.photos[index]
                        let newPhotoResult = PhotoResult(
                            id: photo.id,
                            createdAt: photo.createdAt?.description,
                            width: Int(photo.size.width),
                            height: Int(photo.size.height),
                            description: photo.welcomeDescription ??
                            ImagesMessage.empty.rawValue,
                            urls: UrlsResult(full: photo.largeImageURL,
                                             thumb: photo.thumbImageURL),
                            likedByUser: !photo.isLiked
                        )
                        let newPhoto = Photo(
                            photoResult: newPhotoResult,
                            dateFormat: self.dateFormat)
                        self.photos = self.photos.withReplaced(itemAt: index, newValue: newPhoto)
                        completion(.success(()))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
        self.currentTask = task
        task.resume()
    }
}

private extension ImagesListService {
    func makeLikeRequest(isLike: Bool, photoId: String) -> URLRequest? {
        return builder.makeHTTPRequest(
            path: "photos/\(photoId)/like",
            httpMethod: isLike ? HTTPMethod.post.rawValue : HTTPMethod.delete.rawValue,
            baseURL: baseURLString
        )
    }
}
