//
// RoomsNavigatorMock.swift
// MyHome
//
// Created by Tin Blanc on 7/6/18.
// Copyright © 2018 tanth. All rights reserved.
//

@testable import MyHome

final class RoomsNavigatorMock: RoomsNavigatorType {

    // MARK: - toRooms
    var toRooms_Called = false
    func toRooms() {
        toRooms_Called = true
    }

    // MARK: - toRoomDetail
    var toRoomDetail_Called = false
    func toRoomDetail(room: Room) {
        toRoomDetail_Called = true
    }
}
