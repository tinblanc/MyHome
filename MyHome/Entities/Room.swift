//
//  Room.swift
//  MyHome
//
//  Created by Tin Blanc on 4/16/18.
//  Copyright © 2018 Tin Blanc. All rights reserved.
//

import Foundation
import ObjectMapper

struct Room {
    var id: String
    var userId: String
    var contractId: String
    var name: String
    var oldElectricityUsed: Int
    var newElectricityUsed: Int
    var isUseInternet: Bool
    var isUseCleaning: Bool
    var numberPeople: Int
    var price: Double
    var dateOfPayment: Date?
}

extension Room {
    init() {
        self.init(
            id: "",
            userId: "",
            contractId: "",
            name: "",
            oldElectricityUsed: 0,
            newElectricityUsed: 0,
            isUseInternet: false,
            isUseCleaning: true,
            numberPeople: 1,
            price: 0.0,
            dateOfPayment: nil
        )
    }
}

extension Room: Then, HasID, Hashable { }

extension Room: Mappable {
    
    init?(map: Map) {
        self.init()
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        userId <- map["userId"]
        contractId <- map["contractId"]
        name <- map["name"]
        oldElectricityUsed <- map["oldElectricityUsed"]
        newElectricityUsed <- map["newElectricityUsed"]
        isUseInternet <- map["isUseInternet"]
        isUseCleaning <- map["isUseCleaning"]
        numberPeople <- map["numberPeople"]
        price <- map["price"]
        
        dateOfPayment <- (map["dateOfPayment"], DateTransform())
    }
}
