//
//  Array+ReplacedItem.swift
//  ImageFeed
//
//  Created by Тимур Мурадов on 28.09.2023.
//

import Foundation

extension Array {
    func withReplaced(itemAt index: Int, newValue: Element) -> Array {
        var photos = self
        photos[index] = newValue
        return photos
    }
}
