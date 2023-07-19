//
//  UIBlockingProgressHUD.swift
//  ImageFeed
//
//  Created by Тимур Мурадов on 19.06.2023.
//

import UIKit
import ProgressHUD


final class UIBlockingProgressHUD {
    private static var window: UIWindow? {
        return UIApplication.shared.windows.first
    }
    
    static func show() {
        window?.isUserInteractionEnabled = false
        ProgressHUD.show()
    }
    
    static func dismiss() {
        DispatchQueue.main.async {
            window?.isUserInteractionEnabled = true
            ProgressHUD.dismiss()
        }
    }

}
