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
        let phoneNumberValidate: Driver<ValidationResult>
        let depositsValidate: Driver<ValidationResult>
        let startDateValidate: Driver<ValidationResult>
        
        // For setup Data
        let roomName: Driver<String>
        let price: Driver<String>
        let oldElectricity: Driver<String>
        let startDate: Driver<String>
    }

    let navigator: RentNavigatorType
    let useCase: RentUseCaseType
    var room: Room

    func transform(_ input: Input) -> Output {
        let activityIndicator = ActivityIndicator()
        let errorTracker = ErrorTracker()
        
        let loading = activityIndicator.asDriver()
        let error = errorTracker.asDriver()
        
        // Setup First Data
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
        
        let phoneNumberValidate = input.phoneNumber
            .map { ValidationInput.shared.numberValidate(value: $0) }
        
        let depositsValidate = input.deposits
            .map { ValidationInput.shared.numberValidate(value: $0) }
        
        let startDateValidate = input.startDate
            .map { ValidationInput.shared.requireValidate(value: $0) }
        
        let submitEnable = Driver.combineLatest(priceValidate,
                                                oldElectricityValidate,
                                                numberPeoplesValidate,
                                                userNameValidate,
                                                phoneNumberValidate,
                                                depositsValidate,
                                                startDateValidate)
            .map { (arg) -> Bool in
                let (priceValidate, oldElectricityValidate, numberPeoplesValidate, userNameValidate, phoneNumberValidate, depositsValidate, startDateValidate) = arg
                return priceValidate.isValid
                    && oldElectricityValidate.isValid
                    && numberPeoplesValidate.isValid
                    && userNameValidate.isValid
                    && phoneNumberValidate.isValid
                    && depositsValidate.isValid
                    && startDateValidate.isValid
                
        }
        
        // Trigger
        let inputCombineA = Driver.combineLatest(
            input.price,
            input.oldElectricity,
            input.numberPeoples,
            input.userName,
            input.phoneNumber,
            input.deposits,
            input.note
        )
        
        let inputCombineB = Driver.combineLatest(
            input.startDate,
            input.internet
        )
        
        let submited = input.submitTrigger
            .withLatestFrom(Driver.combineLatest(inputCombineA, inputCombineB) )
            .flatMapLatest({ arg -> Driver<Void> in
                let (arg1, arg2) = arg
                let (price, oldElectricity, numberPeoples, userName, phoneNumber, deposits, note) = arg1
                let (startDate, internet) = arg2
                
                if let price = Int(price),
                    let oldElectricity = Int(oldElectricity),
                    let numberPeoples = Int(numberPeoples),
                    let deposits = Int(deposits) {
                    // Create Room
                    let room = Room().with {
                        $0.id = self.room.id
                        $0.price = price
                        $0.oldElectricityUsed = oldElectricity
                        $0.numberPeoples = numberPeoples
                        $0.deposits = deposits
                        $0.note = note
                        $0.startDate = startDate
                        $0.isUseInternet = internet
                    }
                    // Create User
                    let user = User().with {
                        $0.name = userName
                        $0.phoneNumber = phoneNumber
                    }
                    
                    return self.useCase.rent(room: room, user: user)
                        .trackError(errorTracker)
                        .trackActivity(activityIndicator)
                        .asDriverOnErrorJustComplete()
                }

                return Driver.empty()
            })
            .mapToVoid()
            .do(onNext: navigator.showAlertSuccess)
        
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
                      phoneNumberValidate: phoneNumberValidate,
                      depositsValidate: depositsValidate,
                      startDateValidate: startDateValidate,
                      roomName: roomName,
                      price: price,
                      oldElectricity: oldElectricity,
                      startDate: startDate)
    }
}
