//
// RoomsViewModel.swift
// MyHome
//
// Created by Tin Blanc on 7/6/18.
// Copyright © 2018 tanth. All rights reserved.
//

struct RoomsViewModel: ViewModelType {
    struct Input {
        let loadTrigger: Driver<Void>
        let reloadTrigger: Driver<Void>
        let loadMoreTrigger: Driver<Void>
        let selectRoomTrigger: Driver<IndexPath>
    }

    struct Output {
        let error: Driver<Error>
        let loading: Driver<Bool>
        let refreshing: Driver<Bool>
        let loadingMore: Driver<Bool>
        let fetchItems: Driver<Void>
        let roomList: Driver<[RoomModel]>
        let selectedRoom: Driver<Void>
        let isEmptyData: Driver<Bool>
    }

    struct RoomModel {
        let room: Room
    }

    let navigator: RoomsNavigatorType
    let useCase: RoomsUseCaseType

    func transform(_ input: Input) -> Output {
        let loadMoreOutput = setupLoadMorePaging(
            loadTrigger: input.loadTrigger,
            getItems: useCase.getRoomList,
            refreshTrigger: input.reloadTrigger,
            refreshItems: useCase.getRoomList,
            loadMoreTrigger: input.loadMoreTrigger,
            loadMoreItems: useCase.loadMoreRoomList)
        let (page, fetchItems, loadError, loading, refreshing, loadingMore) = loadMoreOutput

        let roomList = page
            .map { $0.items.map { RoomModel(room: $0) } }
            .asDriverOnErrorJustComplete()

        let selectedRoom = input.selectRoomTrigger
            .withLatestFrom(roomList) {
                return ($0, $1)
            }
            .map { indexPath, roomList in
                return roomList[indexPath.row]
            }
            .do(onNext: { room in
                self.navigator.toRoomDetail(room: room.room)
            })
            .mapToVoid()

        let isEmptyData = Driver.combineLatest(roomList, loading)
            .filter { !$0.1 }
            .map { $0.0.isEmpty }

        return Output(
            error: loadError,
            loading: loading,
            refreshing: refreshing,
            loadingMore: loadingMore,
            fetchItems: fetchItems,
            roomList: roomList,
            selectedRoom: selectedRoom,
            isEmptyData: isEmptyData
        )
    }
}

