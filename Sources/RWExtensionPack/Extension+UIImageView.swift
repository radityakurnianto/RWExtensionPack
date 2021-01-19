//
//  Extension+UIImageView.swift
//  RWExtensionPack
//
//  Created by Raditya Kurnianto on 9/4/20.
//

import Foundation
import SDWebImage

extension UIImageView {
    @objc public func set(image url: String, placeholder: UIImage?) -> Void {
        self.sd_imageIndicator = SDWebImageActivityIndicator.gray
        self.set(image: url, placholder: placeholder, completion: nil)
    }
    
    @objc public func set(image url: String, placholder: UIImage?, completion: ((UIImage?)->Void)?) -> Void {
        self.sd_setImage(with: URL(string: url)) { [weak self] (image, error, cacheType, imageUrl) in
            if let _ = error {
                self?.image = placholder
                completion?(nil)
            }
            
            self?.image = image
            completion?(image)
        }
    }
}
