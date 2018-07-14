//
// AddRoomViewModel.swift
// MyHome
//
// Created by Tin Blanc on 7/9/18.
// Copyright © 2018 tanth. All rights reserved.
//

struct AddRoomViewModel: ViewModelType {

    struct Input {
        let name: Driver<String>
        let price: Driver<String>
        let addTrigger: Driver<Void>
        let closeTrigger: Driver<Void>
    }

    struct Output {
        let loading: Driver<Bool>
        let error: Driver<Error>
        let added: Driver<Void>
        let close: Driver<Void>
        let addEnable: Driver<Bool>
        let nameValidate: Driver<ValidationResult>
        let priceValidate: Driver<ValidationResult>
    }

    let navigator: AddRoomNavigatorType
    let useCase: AddRoomUseCaseType

    func transform(_ input: Input) -> Output {
        let activityIndicator = ActivityIndicator()
        let errorTracker = ErrorTracker()
        
        let loading = activityIndicator.asDriver()
        let error = errorTracker.asDriver()
        
        // Validate
        let nameValidate = input.name
            .map { ValidationInput.shared.nameValidate(name: $0) }
        
        let priceValidate = input.price
            .map { ValidationInput.shared.priceValidate(price: $0) }
        
        let addEnable = Driver.combineLatest(nameValidate, priceValidate)
            .map { (arg) -> Bool in
                let (nameValidate, priceValidate) = arg
                return nameValidate.isValid && priceValidate.isValid
            }
        
        // Add Trigger
        let added = input.addTrigger
            .withLatestFrom( Driver.combineLatest(input.name, input.price) )
            .flatMapLatest { (arg) -> Driver<Void> in
                let (name, price) = arg
                guard let priceB = Double(price) else { return Driver.empty() }
                return self.useCase.addRoom(name: name, price: priceB)
                    .trackError(errorTracker)
                    .trackActivity(activityIndicator)
                    .asDriverOnErrorJustComplete()
            }
            .do(onNext: navigator.showAlertSuccess)
        
        let closed = input.closeTrigger
            .do(onNext: navigator.close)
        
        return Output(loading: loading,
                      error: error,
                      added: added,
                      close: closed,
                      addEnable: addEnable,
                      nameValidate: nameValidate,
                      priceValidate: priceValidate)
    }
}
