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
        let addRoomTrigger: Driver<Void>
        let selectRoomTrigger: Driver<IndexPath>
    }

    struct Output {
        let error: Driver<Error>
        let loading: Driver<Bool>
        let roomList: Driver<[RoomModel]>
        let selectedRoom: Driver<(RoomsNavigator.ActionType, Room)>
        let addRoom: Driver<Void>
        let isEmptyData: Driver<Bool>
    }

    struct RoomModel {
        let room: Room
    }

    let navigator: RoomsNavigatorType
    let useCase: RoomsUseCaseType

    func transform(_ input: Input) -> Output {
        let errorTracker = ErrorTracker()
        let activityIndicator = ActivityIndicator()

        let roomList = input.loadTrigger
            .flatMapLatest({ (_) in
                self.useCase.getRoomList()
                    .trackError(errorTracker)
                    .trackActivity(activityIndicator)
                    .asDriverOnErrorJustComplete()
            })
            .map { $0.map { RoomModel(room: $0) } }

        let selectedRoom = input.selectRoomTrigger
            .withLatestFrom(roomList) {
                return ($0, $1)
            }
            .map { indexPath, roomList in
                return roomList[indexPath.row]
            }
            .flatMapLatest({ (roomModel) in
                self.navigator.showAllOption(room: roomModel.room)
                    .trackError(errorTracker)
                    .map { ($0, roomModel.room) }
                    .asDriverOnErrorJustComplete()
            })
            .do(onNext: { (actionType, room) in
                // Chọn Chức Năng
                switch actionType {
                case .rent:
                    self.navigator.toRent(room: room)
                case .writeTotalElectric:
                    self.navigator.toWriteTotalElectric(room: room)
                case .createBill:
                    self.navigator.toCreateBill(room: room)
                case .checkout:
                    self.navigator.toCheckout(room: room)
                case .none:
                    print("Huỷ")
                }
            })
        
        let addRoom = input.addRoomTrigger
            .do(onNext: navigator.toAddRoom)
        
        let loadError = errorTracker.asDriver()
        let loading = activityIndicator.asDriver()

        let isEmptyData = Driver.combineLatest(roomList, loading)
            .filter { !$0.1 }
            .map { $0.0.isEmpty }

        return Output(
            error: loadError,
            loading: loading,
            roomList: roomList,
            selectedRoom: selectedRoom,
            addRoom: addRoom,
            isEmptyData: isEmptyData
        )
    }
}

