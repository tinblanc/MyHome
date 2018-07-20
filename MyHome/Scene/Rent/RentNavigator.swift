//
// RentNavigator.swift
// MyHome
//
// Created by Tin Blanc on 7/9/18.
// Copyright © 2018 tanth. All rights reserved.
//

protocol RentNavigatorType {
    func close()
}

struct RentNavigator: RentNavigatorType {
    unowned let navigationController: UINavigationController
    
    func close() {
        navigationController.dismiss(animated: true, completion: nil)
    }
}
