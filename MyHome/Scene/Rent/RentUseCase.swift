//
// RentUseCase.swift
// MyHome
//
// Created by Tin Blanc on 7/9/18.
// Copyright © 2018 tanth. All rights reserved.
//

protocol RentUseCaseType {
    func rent(room: Room, user: User) -> Observable<Void>
}

struct RentUseCase: RentUseCaseType {
    func rent(room: Room, user: User) -> Observable<Void> {
        return FirebaseHelper.shared.rentRoom(room: room, user: user)
    }
}
