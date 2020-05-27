//
//  Extension+UITableView.swift
//  RWExtensionPack
//
//  Created by Raditya Kurnianto on 5/26/20.
//

import UIKit

extension UITableView {
    //MARK: registerCell
    public func register<T: UITableViewCell>(cell _: T.Type) where T: Reusable {
        if let nib = T.nib {
            self.register(nib, forCellReuseIdentifier: T.reuseIdentifier)
        } else {
            self.register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
        }
    }
    
    public func dequeueCell<T: UITableViewCell>(indexPath: IndexPath)  -> T where T: Reusable {
        return self.dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as! T
    }
    
    //MARK: registerHeaderFooter
    public func register<T: UITableViewHeaderFooterView>(headerFooterView _: T.Type) where T: Reusable {
        if let nib = T.nib {
            self.register(nib, forHeaderFooterViewReuseIdentifier: T.reuseIdentifier)
        } else {
            self.register(T.self, forHeaderFooterViewReuseIdentifier: T.reuseIdentifier)
        }
    }
    
    public func dequeueHeaderFooter<T: UITableViewHeaderFooterView>(_ viewType: T.Type = T.self) -> T? where T: Reusable {
        return self.dequeueReusableHeaderFooterView(withIdentifier: viewType.reuseIdentifier) as! T?
    }
}
