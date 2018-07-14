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
    func toAddRoom()
    func showAllOption(room: Room) -> Observable<RoomsNavigator.ActionType>
    func toRent(room: Room)
    func toWriteTotalElectric(room: Room)
    func toCreateBill(room: Room)
    func toCheckout(room: Room)
}

struct RoomsNavigator: RoomsNavigatorType {
    unowned let navigationController: UINavigationController
    
    enum ActionType {
        case rent // Cho Thuê
        case writeTotalElectric // Ghi Số Điện
        case createBill // Tạo hoá đơn
        case checkout // Trả Phòng
        case none
    }

    func toRooms() {
        let vc = RoomsViewController.instantiate()
        let vm = RoomsViewModel(navigator: self, useCase: RoomsUseCase())
        vc.bindViewModel(to: vm)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showAllOption(room: Room) -> Observable<ActionType> {
        return Observable.create({ (observer) -> Disposable in
            let actionSheet = UIAlertController(
                title: nil,
                message: nil,
                preferredStyle: isIPad()
                    ? .alert
                    : .actionSheet
            )
            
            if room.userId.isEmpty {
                // Chưa có người thuê
                let leaseAction = UIAlertAction(
                    title: "rooms.popup.button.lease.title".localized(),
                    style: .default) { (_) in
                        observer.onNext(.rent)
                }
                actionSheet.addAction(leaseAction)
            } else {
                // Đã có người thuê
                let writeTotalElectricAction = UIAlertAction(
                    title: "rooms.popup.button.write.total.electricity.title".localized(),
                    style: .default) { (_) in
                        observer.onNext(.writeTotalElectric)
                }
                actionSheet.addAction(writeTotalElectricAction)
                
                let createBillAction = UIAlertAction(
                    title: "rooms.popup.button.create.bill.title".localized(),
                    style: .default) { (_) in
                        observer.onNext(.createBill)
                }
                actionSheet.addAction(createBillAction)
                
                let checkoutAction = UIAlertAction(
                    title: "rooms.popup.button.checkout.title".localized(),
                    style: .destructive) { (_) in
                        observer.onNext(.checkout)
                }
                actionSheet.addAction(checkoutAction)
            }
            
            let cancelAction = UIAlertAction(title: "common.cancel".localized(), style: .cancel)
            actionSheet.addAction(cancelAction)
            
            self.navigationController.present(actionSheet, animated: true)
            
            return Disposables.create()
        })
    }

    func toRoomDetail(room: Room) {
        navigationController.showError(message: "\(#function) not implement !")
    }
    
    func toAddRoom() {
        let vc = AddRoomViewController.instantiate()
        let baseNavigation = BaseNavigationController(rootViewController: vc)
        let navigator = AddRoomNavigator(navigationController: baseNavigation)
        let vm = AddRoomViewModel(navigator: navigator, useCase: AddRoomUseCase())
        vc.bindViewModel(to: vm)
        navigationController.present(baseNavigation, animated: true, completion: nil)
    }
    
    func toRent(room: Room) {
        navigationController.showError(message: "\(#function) not implement !")
    }
    
    func toWriteTotalElectric(room: Room) {
        navigationController.showError(message: "\(#function) not implement !")
    }
    
    func toCreateBill(room: Room) {
        navigationController.showError(message: "\(#function) not implement !")
    }
    
    func toCheckout(room: Room) {
        navigationController.showError(message: "\(#function) not implement !")
    }
}

