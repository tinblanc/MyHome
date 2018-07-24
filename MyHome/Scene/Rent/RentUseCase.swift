//
// RentUseCase.swift
// MyHome
//
// Created by Tin Blanc on 7/9/18.
// Copyright © 2018 tanth. All rights reserved.
//

protocol RentUseCaseType {
    func getRoomInfo(roomId: String) -> Observable<Room?>
}

struct RentUseCase: RentUseCaseType {
    func getRoomInfo(roomId: String) -> Observable<Room?> {
        return FirebaseHelper.shared.getRoomInfo(with: roomId)
    }
}
