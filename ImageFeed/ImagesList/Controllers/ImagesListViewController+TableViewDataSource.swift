//
//  ImageListViewController+TableViewDataSource.swift
//  ImageFeed
//
//  Created by Тимур Мурадов on 28.09.2023.
//

import UIKit

extension ImagesListViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ImageListConstants.Strings.imagesListCellIdentifire.rawValue, for: indexPath)
        cell.selectionStyle = .none
        
        guard let imageListCell = cell as? ImagesListCell else {
            return UITableViewCell()
        }
        
        let photo = photos[indexPath.row]
        
        imageListCell.delegate = self
        imageListCell.updateCell(from: photo)
        return imageListCell
    }
}
