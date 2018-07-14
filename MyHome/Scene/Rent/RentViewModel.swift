//
// RentViewModel.swift
// MyHome
//
// Created by Tin Blanc on 7/9/18.
// Copyright © 2018 tanth. All rights reserved.
//

struct RentViewModel: ViewModelType {

    struct Input {

    }

    struct Output {

    }

    let navigator: RentNavigatorType
    let useCase: RentUseCaseType

    func transform(_ input: Input) -> Output {
        return Output()
    }
}
