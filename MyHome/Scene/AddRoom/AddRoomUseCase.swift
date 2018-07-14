//
// AddRoomUseCase.swift
// MyHome
//
// Created by Tin Blanc on 7/9/18.
// Copyright © 2018 tanth. All rights reserved.
//

protocol AddRoomUseCaseType {
    func addRoom(name: String, price: Double) -> Observable<Void>
}

struct AddRoomUseCase: AddRoomUseCaseType {
    func addRoom(name: String, price: Double) -> Observable<Void> {
        // TODO: Handle Add Room
        return Observable.just(())
    }
}
