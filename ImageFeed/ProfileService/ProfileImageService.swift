//
//  ProfileImageService.swift
//  ImageFeed
//
//  Created by Тимур Мурадов on 17.07.2023.
//

import Foundation
import UIKit

protocol ProfileImageServiceProtocol {
    var avatarURL: String? { get }
    func fetchProfileImageURL(_ username: String, completion: @escaping (Result<String, Error>) -> Void)
}

final class ProfileImageService: ProfileImageServiceProtocol {
    static let shared = ProfileImageService()
    static let didChangeNotification = Notification.Name(rawValue: "ProfileImageProviderDidChange")
    
    private var currentTask: URLSessionTask?
    
    private (set) var avatarURL: String?
    private var lastUserName: String?
    private let urlBuilder = URLRequestBuilder.shared
    
    func fetchProfileImageURL(_ userName: String, completion: @escaping (Result<String, Error>) -> Void) {
        assert(Thread.isMainThread)
        
        guard lastUserName != userName else { return }
        currentTask?.cancel()
        lastUserName = userName
        
        guard let request = makeRequest(userName: userName) else { return }
        
        let session = URLSession.shared
        let task = session.objectTask(for: request) { [weak self] (result: Result<ProfileResult, Error>) in
            guard let self =  self else { return }
            switch result {
            case .success(let profilePhoto):
                guard let mediumPhoto = profilePhoto.profileImage?.medium else { return }
                self.avatarURL = mediumPhoto
                completion(.success(mediumPhoto))
                
                NotificationCenter.default.post(
                    name: ProfileImageService.didChangeNotification,
                    object: self,
                    userInfo: [Notification.userInfoImageURLKey: mediumPhoto]
                )
                self.currentTask = nil
            case .failure(let error):
                completion(.failure(error))
                self.lastUserName = nil
            }
        }
        self.currentTask = task
        task.resume()
    }
    
    private func makeRequest(userName: String) -> URLRequest? {
        urlBuilder.makeHTTPRequest(
            path: "/users/\(userName)",
            httpMethod: "GET",
            baseURL: defaultApiBaseURLString
        )
    }
}

extension Notification {
    static let userInfoImageURLKey: String = "URL"
    var userInfoImageURL: String? {
        userInfo?[Notification.userInfoImageURLKey] as? String
    }
}
