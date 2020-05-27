//
//  Extension+Array.swift
//  RWExtensionPack
//
//  Created by Raditya Kurnianto on 5/26/20.
//

import Foundation

extension Array {
    public subscript(index: Int, default defaultValue: @autoclosure () -> Element) -> Element {
        guard index >= 0, index < endIndex else {
            return defaultValue()
        }
        
        return self[index]
    }
}

extension Collection where Indices.Iterator.Element == Index {
    public subscript (exist index: Index) -> Iterator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
