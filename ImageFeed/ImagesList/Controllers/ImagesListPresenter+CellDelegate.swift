//
//  ImagesListPresenter+CellDelegate.swift
//  ImageFeed
//
//  Created by Тимур Мурадов on 28.09.2023.
//

import UIKit

extension ImagesListPresenter: ImagesListCellDelegate {
    func imageListCellDidTapLike(_ cell: ImagesListCell) {
        guard let indexPath = view?.tableView.indexPath(for: cell) else { return }
        let photo = ImagesListService.shared.photos[indexPath.row]
        UIBlockingProgressHUD.show()
        ImagesListService.shared.changeLike(photoId: photo.id, isLike: !photo.isLiked) { result in
            switch result {
            case.success:
                cell.setIsLiked(isLiked: ImagesListService.shared.photos[indexPath.row].isLiked)
                UIBlockingProgressHUD.dismiss()
            case.failure(let error):
                UIBlockingProgressHUD.dismiss()
                self.showLikeAlert(with: error)
            }
        }
    }
    
    func showLikeAlert(with error: Error) {
        let alert = UIAlertController(title: ImagesMessage.likeAllertSomethingWrong.rawValue,
                                      message: ImagesMessage.likeAlertMessage.rawValue,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: ImagesMessage.likeAlertActionTitle.rawValue,
                                      style: .cancel))
        self.view?.present(alert)
    }
}
