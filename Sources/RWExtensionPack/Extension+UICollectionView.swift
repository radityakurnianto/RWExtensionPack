//
//  Extension+UICollectionView.swift
//  RWExtensionPack
//
//  Created by Raditya Kurnianto on 5/26/20.
//

import Foundation
import UIKit

extension UICollectionView {
    public func register<T: UICollectionViewCell>(cell _: T.Type) where T: Reusable {
        if let nib = T.nib {
            self.register(nib, forCellWithReuseIdentifier: T.reuseIdentifier)
        } else {
            self.register(T.self, forCellWithReuseIdentifier: T.reuseIdentifier)
        }
    }
    
    public func dequeueCell<T: UICollectionViewCell>(indexPath: IndexPath) -> T where T: Reusable {
        return self.dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as! T
    }
}
