//
//  SingleImageViewController.swift
//  ImageFeed
//
//  Created by Тимур Мурадов on 18.05.2023.
//

import UIKit
import Kingfisher

class SingleImageViewController: UIViewController {

    @IBOutlet var scrollView: UIScrollView!
    
    @IBAction private func didTapBackButton() {
        dismiss(animated: true, completion: nil)
    }
    
    var image: URL? {
            didSet {
                guard isViewLoaded else { return }
                showImage(url: image)
            }
        }

    @IBOutlet var imageView: UIImageView!
    
    override func viewDidLoad() {
           super.viewDidLoad()
        
        scrollView.minimumZoomScale = 0.1
        scrollView.maximumZoomScale = 1.25
        showImage(url: image)
       }
    
    func showImage(url: URL?) {
        guard let url = url else { return }
        UIBlockingProgressHUD.show()
        imageView.kf.setImage(with: url) { [weak self] result in
            UIBlockingProgressHUD.dismiss()
            guard let self = self else { return }
            switch result {
            case .success(let imageResult):
                self.rescaleAndCenterImageInScrollView(image: imageResult.image)
            case .failure:
                self.showAlert(url: url)
            }
            
        }
    }
    
    @IBAction func didTapShareButton(_ sender: UIButton) {
        let share = UIActivityViewController(
            activityItems: [image],
            applicationActivities: nil
        )
        present(share, animated: true, completion: nil)
    }
    
    private func rescaleAndCenterImageInScrollView(image: UIImage) {
        let minZoomScale = scrollView.minimumZoomScale
        let maxZoomScale = scrollView.maximumZoomScale
        view.layoutIfNeeded()
        let visibleRectSize = scrollView.bounds.size
        let imageSize = image.size
        let hScale = visibleRectSize.width / imageSize.width
        let vScale = visibleRectSize.height / imageSize.height
        let scale = min(maxZoomScale, max(minZoomScale, max(hScale, vScale)))
        scrollView.setZoomScale(scale, animated: false)
        scrollView.layoutIfNeeded()
        let newContentSize = scrollView.contentSize
        let x = (newContentSize.width - visibleRectSize.width) / 2
        let y = (newContentSize.height - visibleRectSize.height) / 2
        scrollView.setContentOffset(CGPoint(x: x, y: y), animated: false)
    }
    
    fileprivate func showAlert(url: URL?) {
        let alert = UIAlertController(title: "что-то пошло не так", message: "попробуй еще раз", preferredStyle: .alert)
        let action = UIAlertAction(title: "повторить", style: .default)
        let cancelAction = UIAlertAction(title: "не надо", style: .cancel) { [weak self] _ in
            guard let self = self else { return }
            self.showImage(url: url)
        }
        alert.addAction(action)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
}

extension SingleImageViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        imageView
    }
}
