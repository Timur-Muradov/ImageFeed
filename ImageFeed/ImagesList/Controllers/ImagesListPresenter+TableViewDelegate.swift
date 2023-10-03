//
//  ImagesListPresenter+TableViewDelegate.swift
//  ImageFeed
//
//  Created by Тимур Мурадов on 28.09.2023.
//

import UIKit

extension ImagesListPresenter: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let image = ImagesListService.shared.photos[indexPath.row].largeImageURL
        self.view?.present(for: indexPath, image: image)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let image = ImagesListService.shared.photos[indexPath.row]
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
        if indexPath.row + 1 == ImagesListService.shared.photos.count {
            ImagesListService.shared.fetchPhotoNextPage()
        }
    }
}
