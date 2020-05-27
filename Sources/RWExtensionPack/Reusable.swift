//
//  Reusable.swift
//  RWExtensionPack
//
//  Created by Raditya Kurnianto on 5/26/20.
//

import UIKit

public protocol Reusable: class {
    static var reuseIdentifier: String { get }
    static var nib: UINib? { get }
}

extension Reusable {
    public static var reuseIdentifier: String { return String(describing: self) }
    public static var nib: UINib? { return UINib(nibName: String(describing: self), bundle: Bundle(for: self)) }
}

