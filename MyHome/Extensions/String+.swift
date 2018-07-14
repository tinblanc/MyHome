//
//  String+.swift
//  MyHome
//
//  Created by Tin Blanc on 7/14/18.
//  Copyright © 2018 Tin Blanc. All rights reserved.
//

import UIKit

extension String {
    func substring(to index: Int, delimiter: Bool = true) -> String {
        if index > self.count - 1 {
            return self
        }
        return substring(from: 0, to: index) + (delimiter ? "..." : "")
    }
    
    func substring(from: Int, to: Int) -> String {
        let start = index(startIndex, offsetBy: from)
        let end = index(start, offsetBy: to - from)
        return String(self[start ..< end])
    }
    
    var containsWhitespace: Bool {
        return(self.rangeOfCharacter(from: .whitespacesAndNewlines) != nil)
    }
    
    static func randomName() -> String {
        return UUID().uuidString.replacingOccurrences(of: "-", with: "")
    }
}

extension String {
    func fileName() -> String {
        return NSURL(fileURLWithPath: self).deletingPathExtension?.lastPathComponent ?? ""
    }
    
    func fileExtension() -> String {
        return NSURL(fileURLWithPath: self).pathExtension ?? ""
    }
}
