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
    var renterId: String
    var contractId: String
    var name: String
    var oldElectricityUsed: Int
    var newElectricityUsed: Int
    var isUseInternet: Bool
    var isUseCleaning: Bool
    var numberPeoples: Int
    var price: Int
    var dateOfPayment: Date?
    var deposits: Int
    
    var note: String
    var startDate: String?
}

extension Room {
    init() {
        self.init(
            id: "",
            renterId: "",
            contractId: "",
            name: "",
            oldElectricityUsed: 0,
            newElectricityUsed: 0,
            isUseInternet: false,
            isUseCleaning: true,
            numberPeoples: 1,
            price: 0,
            dateOfPayment: nil,
            deposits: 0,
            note: "",
            startDate: nil
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
        renterId <- map["renterId"]
        contractId <- map["contractId"]
        name <- map["name"]
        oldElectricityUsed <- map["oldElectricityUsed"]
        newElectricityUsed <- map["newElectricityUsed"]
        isUseInternet <- map["isUseInternet"]
        isUseCleaning <- map["isUseCleaning"]
        numberPeoples <- map["numberPeople"]
        price <- map["price"]
        
        dateOfPayment <- (map["dateOfPayment"], DateTransform())
        deposits <- map["deposits"]
        
        note <- map["note"]
        startDate <- map["startDate"]
    }
}
