//
// RentViewModel.swift
// MyHome
//
// Created by Tin Blanc on 7/9/18.
// Copyright © 2018 tanth. All rights reserved.
//

struct RentViewModel: ViewModelType {

    struct Input {
        let addTrigger: Driver<Void>
        let closeTrigger: Driver<Void>
        
        // Info
        let price: Driver<String>
        let oldElectricity: Driver<String>
        let numberPeoples: Driver<String>
        let userName: Driver<String>
        let phoneNumber: Driver<String>
        let deposits: Driver<String>
        let note: Driver<String>
        let startDate: Driver<String>
        let internet: Driver<Bool>
    }

    struct Output {
        let added: Driver<Void>
        let close: Driver<Void>
    }

    let navigator: RentNavigatorType
    let useCase: RentUseCaseType

    func transform(_ input: Input) -> Output {
        // Add Trigger
        let closed = input.closeTrigger
            .do(onNext: navigator.close)
        
        return Output(added: Driver.empty(),
                      close: closed)
    }
}
