//
//  Regex.swift
//  RWExtensionPack
//
//  Created by Raditya Kurnianto on 9/21/20.
//

import Foundation

public class Regex {
    static public func check(keyword: String, against pattern: String) -> Bool {
        let searchRange = NSRange(location: 0, length: keyword.count)
        var error: Error = nil
        
        let regex = try NSRegularExpression(pattern: pattern, options: .caseInsensitive)
        let match = regex.firstMatch(in: keyword, options: [], range: searchRange)
        guard let matched = match else { return false }
        return matched.numberOfRanges > 0
    }
}
