//
//  ViewController.swift
//  ImageFeed
//
//  Created by Тимур Мурадов on 07.05.2023.
//

import UIKit
import Kingfisher

final class ImagesListViewController: UIViewController & ImagesListViewControllerProtocol {
    var presenter: ImagesListPresenterProtocol?
    @IBOutlet var tableView: UITableView!
    private var largeImageURL: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = presenter as? any UITableViewDelegate
        self.tableView.dataSource = self
        self.presenter?.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == ImagesMessage.singleImageViewControllerIdentifier.rawValue {
            let viewController = segue.destination as! SingleImageViewController
            let image = largeImageURL
            let imageURL = URL(string: image)
            viewController.image = imageURL
        } else {
            super.prepare(for: segue, sender: sender)
        }
    }
    
    func present(_ alert: UIAlertController) {
        self.present(alert, animated: true, completion: nil)
    }
    
    func present(for indexPath: IndexPath, image: String) {
        self.largeImageURL = image
        performSegue(withIdentifier: ImagesMessage.singleImageViewControllerIdentifier.rawValue, sender: indexPath)
    }
}
