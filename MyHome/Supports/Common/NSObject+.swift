//
//  NSObject+.swift
//  Knot
//
//  Created by tran.huu.tan on 1/24/18.
//  Copyright © 2018 Framgia. All rights reserved.
//

import UIKit

extension NSObject {
    var className: String {
        return String(describing: type(of: self))
    }
    
    class var className: String {
        return String(describing: self)
    }
}
