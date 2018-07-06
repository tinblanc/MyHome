//
// RoomsUseCase.swift
// MyHome
//
// Created by Tin Blanc on 7/6/18.
// Copyright © 2018 tanth. All rights reserved.
//

protocol RoomsUseCaseType {
    func getRoomList() -> Observable<PagingInfo<Room>>
    func loadMoreRoomList(page: Int) -> Observable<PagingInfo<Room>>
}

struct RoomsUseCase: RoomsUseCaseType {
    func getRoomList() -> Observable<PagingInfo<Room>> {
        return loadMoreRoomList(page: 1)
    }

    func loadMoreRoomList(page: Int) -> Observable<PagingInfo<Room>> {
        return Observable.empty()
    }
}

