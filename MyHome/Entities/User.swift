//
//  User.swift
//  MyHome
//
//  Created by tran.huu.tan on 7/25/18.
//  Copyright © 2018 Tin Blanc. All rights reserved.
//

import Foundation
import ObjectMapper

struct User {
    var id: String
    var name: String
    var phoneNumber: String
}

extension User {
    init() {
        self.init(
            id: "",
            name: "",
            phoneNumber: ""
        )
    }
}

extension User: Then, HasID, Hashable { }

extension User: Mappable {
    
    init?(map: Map) {
        self.init()
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        phoneNumber <- map["phoneNumber"]
    }
}
