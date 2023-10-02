//
//  ImagesListViewController+TableViewDelegate.swift
//  ImageFeed
//
//  Created by Тимур Мурадов on 28.09.2023.
//

import UIKit

extension ImagesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: ImagesMessage.singleImageViewControllerIdentifier.rawValue, sender: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let image = photos[indexPath.row]
        let imageInsets = UIEdgeInsets(top: ContentInset.imageVertical,
                                       left: ContentInset.imageHorizontal,
                                       bottom: ContentInset.imageVertical,
                                       right: ContentInset.imageHorizontal)
        let imageViewWidth = tableView.bounds.width - imageInsets.left - imageInsets.right
        let imageWidth = image.size.width
        let scale = imageViewWidth / imageWidth
        let cellHeight = image.size.height * scale + imageInsets.top + imageInsets.bottom
        
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == photos.count {
            ImagesListService.shared.fetchPhotoNextPage()
        }
    }
}
