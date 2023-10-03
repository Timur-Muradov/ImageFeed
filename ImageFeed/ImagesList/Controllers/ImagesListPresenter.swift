//
//  ImagesListPresenter.swift
//  ImageFeed
//
//  Created by Тимур Мурадов on 29.09.2023.
//

import UIKit

final class ImagesListPresenter: NSObject & ImagesListPresenterProtocol {
    weak var view: ImagesListViewControllerProtocol?
    private var imagesListServiceObserver: NSObjectProtocol?
    
    init(view: ImagesListViewControllerProtocol) {
        self.view = view
    }
    
    func viewDidLoad() {
        view?.tableView.contentInset = UIEdgeInsets(top: ContentInset.table,
                                              left: 0,
                                              bottom: ContentInset.table,
                                              right: 0)
        
        imagesListServiceObserver = NotificationCenter.default.addObserver(
            forName: NotificationNames.didChange,
            object: nil,
            queue: .main
        ) { [weak self] notification in
            guard let self = self else { return }
            self.updateTableViewAnimated()
        }
        ImagesListService.shared.fetchPhotoNextPage()
    }
    
    func updateTableViewAnimated() {
        view?.tableView.performBatchUpdates {
            let indexPath = (ImagesListService.shared.lastPhotosCount..<ImagesListService.shared.photos.count).map { IndexPath(row: $0, section: 0) }
            view?.tableView.insertRows(at: indexPath, with: .fade)
        } completion: { _ in }
    }
}
