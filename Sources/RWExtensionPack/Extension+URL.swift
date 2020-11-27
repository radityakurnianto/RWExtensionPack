//
//  Extension+URL.swift
//  RWExtensionPack
//
//  Created by Raditya Kurnianto on 11/27/20.
//

import Foundation

extension URL {
    var isValidURL: Bool {
        let regEx = "((https|http)://)((\\w|-)+)(([.]|[/])((\\w|-)+))+"
        let predicate = NSPredicate(format:"SELF MATCHES %@", argumentArray:[regEx])
        return predicate.evaluate(with: self.absoluteString)
    }
}
