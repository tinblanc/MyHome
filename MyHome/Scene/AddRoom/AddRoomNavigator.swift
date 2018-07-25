//
// AddRoomNavigator.swift
// MyHome
//
// Created by Tin Blanc on 7/9/18.
// Copyright © 2018 tanth. All rights reserved.
//

protocol AddRoomNavigatorType {
    func showAlertSuccess()
    func close()
}

struct AddRoomNavigator: AddRoomNavigatorType {
    unowned let navigationController: UINavigationController
    
    func showAlertSuccess() {
        navigationController.view.endEditing(true)
        
        navigationController.showAutoCloseMessage(
            image: nil,
            title: "common.success".localized(),
            message: "add.room.success".localized(),
            interval: 1.0) {
                self.close()
        }
    }
    
    func close() {
        navigationController.dismiss(animated: true, completion: nil)
    }
}
