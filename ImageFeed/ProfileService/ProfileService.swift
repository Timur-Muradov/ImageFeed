//
//  ProfileService.swift
//  ImageFeed
//
//  Created by Тимур Мурадов on 26.06.2023.
//

import Foundation

final class ProfileService {
    
    private let builder: URLRequestBuilder
    init(builder: URLRequestBuilder = .shared) {
        self.builder = builder
    }
    static let shared = ProfileService()
    private(set) var profile: Profile?
    private var currentTask: URLSessionTask?
    
    func fetchProfile(_ token: String, completion: @escaping (Result<Profile, Error>) -> Void) {
        
        currentTask?.cancel()
        
        guard let request = makeFetchProfileRequest(token: token) else {
            assertionFailure ("Invalid request")
            completion(.failure (NetworkError.urlSessionError))
            return
        }
        
        let session = URLSession.shared
        currentTask = session.objectTask(for: request) {
            [weak self] (response: Result<ProfileResult, Error>) in
            self?.currentTask = nil
            switch response {
            case .success(let profileResult):
                let profile = Profile(result: profileResult)
                self?.profile = profile
                completion(.success(profile))
            case .failure(let error):
                completion(.failure (error))
            }
        }
    }
        
        private func makeFetchProfileRequest(token: String) -> URLRequest? {
            URLRequestBuilder.makeHTTPRequest(
                path: "/me",
                httpMethod: "GET", baseURL: Constants.defaultApiBaseURLString)
        }
    }
    

