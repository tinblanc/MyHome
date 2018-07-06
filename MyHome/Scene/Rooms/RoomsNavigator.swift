//
// RoomsNavigator.swift
// MyHome
//
// Created by Tin Blanc on 7/6/18.
// Copyright © 2018 tanth. All rights reserved.
//

protocol RoomsNavigatorType {
    func toRooms()
    func toRoomDetail(room: Room)
}

struct RoomsNavigator: RoomsNavigatorType {
    unowned let navigationController: UINavigationController

    func toRooms() {
        let vc = RoomsViewController.instantiate()
        let vm = RoomsViewModel(navigator: self, useCase: RoomsUseCase())
        vc.bindViewModel(to: vm)
        navigationController.pushViewController(vc, animated: true)
    }

    func toRoomDetail(room: Room) {

    }
}

