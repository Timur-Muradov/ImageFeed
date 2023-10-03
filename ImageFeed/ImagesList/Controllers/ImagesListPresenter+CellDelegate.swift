//
//  ImagesListViewController+CellDelegate.swift
//  ImageFeed
//
//  Created by Тимур Мурадов on 28.09.2023.
//

import UIKit

extension ImagesListViewController: ImagesListCellDelegate {
    func imageListCellDidTapLike(_ cell: ImagesListCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let photo = photos[indexPath.row]
        UIBlockingProgressHUD.show()
        ImagesListService.shared.changeLike(photoId: photo.id, isLike: !photo.isLiked) { result in
            switch result {
            case.success:
                self.photos = ImagesListService.shared.photos
                cell.setIsLiked(isLiked: self.photos[indexPath.row].isLiked)
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
        self.present(alert, animated: true, completion: nil)
    }
}
