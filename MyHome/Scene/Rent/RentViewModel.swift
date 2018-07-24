//
// RentViewModel.swift
// MyHome
//
// Created by Tin Blanc on 7/9/18.
// Copyright © 2018 tanth. All rights reserved.
//

struct RentViewModel: ViewModelType {

    struct Input {
        let firstTrigger: Driver<Void>
        let submitTrigger: Driver<Void>
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
        let loading: Driver<Bool>
        let error: Driver<Error>
        let submited: Driver<Void>
        let close: Driver<Void>
        let submitEnable: Driver<Bool>
        
        let priceValidate: Driver<ValidationResult>
        let oldElectricityValidate: Driver<ValidationResult>
        let numberPeoplesValidate: Driver<ValidationResult>
        let userNameValidate: Driver<ValidationResult>
        let depositsValidate: Driver<ValidationResult>
        let startDateValidate: Driver<ValidationResult>
        
        let roomName: Driver<String>
        let price: Driver<String>
        let oldElectricity: Driver<String>
        let startDate: Driver<String>
    }

    let navigator: RentNavigatorType
    let useCase: RentUseCaseType
    let room: Room

    func transform(_ input: Input) -> Output {
        let activityIndicator = ActivityIndicator()
        let errorTracker = ErrorTracker()
        
        let loading = activityIndicator.asDriver()
        let error = errorTracker.asDriver()
        
        // Bind Data
        let roomName = input.firstTrigger
            .map { self.room.name }
        
        let price = input.firstTrigger
            .map { String(format: "%d", self.room.price) }
        
        let oldElectricity = input.firstTrigger
            .map { String(format: "%d", self.room.oldElectricityUsed) }
        
        let startDate = input.firstTrigger
            .map { Date().toDate() }
        
        // Validate
        let priceValidate = input.price
            .map { ValidationInput.shared.numberValidate(value: $0) }
        
        let oldElectricityValidate = input.oldElectricity
            .map { ValidationInput.shared.numberValidate(value: $0) }
        
        let numberPeoplesValidate = input.numberPeoples
            .map { ValidationInput.shared.numberValidate(value: $0) }
        
        let userNameValidate = input.userName
            .map { ValidationInput.shared.nameValidate(name: $0) }
        
        let depositsValidate = input.deposits
            .map { ValidationInput.shared.numberValidate(value: $0) }
        
        let startDateValidate = input.startDate
            .map { ValidationInput.shared.requireValidate(value: $0) }
        
        let submitEnable = Driver.combineLatest(priceValidate,
                                                oldElectricityValidate,
                                                numberPeoplesValidate,
                                                userNameValidate,
                                                depositsValidate,
                                                startDateValidate)
            .map { (arg) -> Bool in
                let (priceValidate, oldElectricityValidate, numberPeoplesValidate, userNameValidate, depositsValidate, startDateValidate) = arg
                return priceValidate.isValid
                    && oldElectricityValidate.isValid
                    && numberPeoplesValidate.isValid
                    && userNameValidate.isValid
                    && depositsValidate.isValid
                    && startDateValidate.isValid
                
        }
        
        // Trigger
        let submited = input.submitTrigger
            .withLatestFrom(input.startDate)
            .do(onNext: { (startDate) in
                print(startDate)
            })
            .mapToVoid()
        
        let closed = input.closeTrigger
            .do(onNext: navigator.close)
        
        return Output(loading: loading,
                      error: error,
                      submited: submited,
                      close: closed,
                      submitEnable: submitEnable,
                      priceValidate: priceValidate,
                      oldElectricityValidate: oldElectricityValidate,
                      numberPeoplesValidate: numberPeoplesValidate,
                      userNameValidate: userNameValidate,
                      depositsValidate: depositsValidate,
                      startDateValidate: startDateValidate,
                      roomName: roomName,
                      price: price,
                      oldElectricity: oldElectricity,
                      startDate: startDate)
    }
}
