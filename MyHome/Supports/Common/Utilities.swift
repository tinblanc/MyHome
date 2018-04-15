//
//  Utilities.swift
//  Knot
//
//  Created by tran.huu.tan on 1/22/18.
//  Copyright © 2018 Framgia. All rights reserved.
//

func after(interval: TimeInterval, completion: (() -> Void)?) {
    DispatchQueue.main.asyncAfter(deadline: .now() + interval) {
        completion?()
    }
}

func isEmptyArray<T>(array: [T]?) -> Bool {
    if let array = array, !array.isEmpty {
        return false
    }
    return true
}
