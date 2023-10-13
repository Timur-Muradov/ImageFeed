//
//  ImagesListPresenterProtocol.swift
//  ImageFeed
//
//  Created by Тимур Мурадов on 28.09.2023.
//

import UIKit

protocol ImagesListPresenterProtocol {
    var view: ImagesListViewControllerProtocol? { get }
    func viewDidLoad()
}
