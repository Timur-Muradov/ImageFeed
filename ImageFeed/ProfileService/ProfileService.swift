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
    private var lastToken: String?
    
    func fetchProfile(_ token: String, completion: @escaping (Result<Profile, Error>) -> Void) {
        assert(Thread.isMainThread)
       

        currentTask?.cancel()
        
        
        guard let request = makeFetchProfileRequest() else {
            assertionFailure ("Invalid request")
            completion(.failure (NetworkError.urlSessionError))
            return
        }
        
        let session = URLSession.shared
        let task = session.objectTask(for: request) {
            [weak self] (response: Result<ProfileResult, Error>) in
            guard let self = self else { return }
            switch response {
            case .success(let profileResult):
                let profile = Profile(result: profileResult)
                self.profile = profile
                completion(.success(profile))
                self.currentTask = nil
            case .failure(let error):
                completion(.failure (error))
            }
        }
        self.currentTask = task
        task.resume()
    }
        
        private func makeFetchProfileRequest() -> URLRequest? {
            builder.makeHTTPRequest(
                path: "/me",
                httpMethod: "GET",
                baseURL: Constants.defaultApiBaseURLString)
        }
    }
    

