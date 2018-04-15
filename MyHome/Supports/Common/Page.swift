//
//  Page.swift
//  MyHome
//
//  Created by Tin Blanc on 4/15/18.
//  Copyright © 2018 Tin Blanc. All rights reserved.
//

import SwiftDate

protocol Pageable {
    var id: Int { get }
}

struct Page<T: Pageable> {
    let items: [T]
    
    var lastObjectID: Int? {
        return items.last.flatMap { $0.id }
    }
}

struct PagingInfo<T: Hashable> {
    let page: Int
    let items: OrderedSet<T>
}
