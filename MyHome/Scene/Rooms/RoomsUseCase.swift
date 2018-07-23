//
// RoomsUseCase.swift
// MyHome
//
// Created by Tin Blanc on 7/6/18.
// Copyright © 2018 tanth. All rights reserved.
//

protocol RoomsUseCaseType {
    func getRoomList() -> Observable<[Room]>
}

struct RoomsUseCase: RoomsUseCaseType {
    func getRoomList() -> Observable<[Room]> {
        return FirebaseHelper.shared.getRooms()
    }
}

