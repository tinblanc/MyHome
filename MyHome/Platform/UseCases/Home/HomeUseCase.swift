//
// HomeUseCase.swift
// KnotBuilder
//
// Created by tran.huu.tan on 4/15/18.
// Copyright © 2018 Framgia. All rights reserved.
//

struct HomeUseCase: HomeUseCaseType {
    func getListRoom() -> Observable<[Room]> {
        let rooms = [
            Room(builder: RoomBuilder().then { $0.id = 301 }),
            Room(builder: RoomBuilder().then { $0.id = 302 }),
            Room(builder: RoomBuilder().then { $0.id = 303 }),
            Room(builder: RoomBuilder().then { $0.id = 304 }),
            Room(builder: RoomBuilder().then { $0.id = 401 }),
            Room(builder: RoomBuilder().then { $0.id = 402 }),
            Room(builder: RoomBuilder().then { $0.id = 403 }),
            Room(builder: RoomBuilder().then { $0.id = 404 }),
            Room(builder: RoomBuilder().then { $0.id = 501 }),
            Room(builder: RoomBuilder().then { $0.id = 502 }),
            Room(builder: RoomBuilder().then { $0.id = 503 }),
            Room(builder: RoomBuilder().then { $0.id = 504 }),
        ]
        
        return Observable.just(rooms)
    }
}
