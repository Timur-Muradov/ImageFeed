//
//  SingleImageViewController.swift
//  ImageFeed
//
//  Created by Тимур Мурадов on 18.05.2023.
//

import Foundation
import UIKit

class SingleImageViewController: UIViewController {
    
    var image: UIImage! {
            didSet {
                guard isViewLoaded else { return } // 1
                imageView.image = image // 2
            }
        }
    
    @IBOutlet var imageView: UIImageView!
    
    override func viewDidLoad() {
           super.viewDidLoad()
           imageView.image = image
       }
    
}
