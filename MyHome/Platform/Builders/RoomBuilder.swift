//
//  RoomBuilder.swift
//  MyHome
//
//  Created by Tin Blanc on 4/16/18.
//  Copyright © 2018 Tin Blanc. All rights reserved.
//

import ObjectMapper

final class RoomBuilder: Then {
    
    var id: Int = 0
    
    init() {
        
    }
    
    init(room: Room) {
        id = room.id
    }
}

extension RoomBuilder: Mappable {
    convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
    }
}

extension Room {
    init(builder: RoomBuilder) {
        self.init(id: builder.id)
    }
    
    init() {
        self.init(builder: RoomBuilder())
    }
}
