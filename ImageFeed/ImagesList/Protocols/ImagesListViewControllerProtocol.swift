//
//  ImagesListViewControllerProtocol.swift
//  ImageFeed
//
//  Created by Тимур Мурадов on 28.09.2023.
//

import UIKit

protocol ImagesListViewControllerProtocol: UIViewController {
    var presenter: ImagesListPresenterProtocol? { get set }
    var tableView: UITableView! { get }
    func present(_ alert: UIAlertController)
    func present(for indexPath: IndexPath, image: String)
}
