//
// RoomsUseCaseMock.swift
// MyHome
//
// Created by Tin Blanc on 7/6/18.
// Copyright © 2018 tanth. All rights reserved.
//

@testable import MyHome
import RxSwift

final class RoomsUseCaseMock: RoomsUseCaseType {

    // MARK: - getRoomList
    var getRoomList_Called = false
    var getRoomList_ReturnValue: Observable<PagingInfo<Room>> = {
        let items = [
            Room().with { $0.id = "1" }
        ]
        let page = PagingInfo<Room>(page: 1, items: OrderedSet(sequence: items))
        return Observable.just(page)
    }()
    func getRoomList() -> Observable<PagingInfo<Room>> {
        getRoomList_Called = true
        return getRoomList_ReturnValue
    }

    // MARK: - loadMoreRoomList
    var loadMoreRoomList_Called = false
    var loadMoreRoomList_ReturnValue: Observable<PagingInfo<Room>> = {
        let items = [
            Room().with { $0.id = "2" }
        ]
        let page = PagingInfo<Room>(page: 2, items: OrderedSet(sequence: items))
        return Observable.just(page)
    }()
    func loadMoreRoomList(page: Int) -> Observable<PagingInfo<Room>> {
        loadMoreRoomList_Called = true
        return loadMoreRoomList_ReturnValue
    }
}
