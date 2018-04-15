//
// HomeViewModel.swift
// KnotBuilder
//
// Created by tran.huu.tan on 4/15/18.
// Copyright © 2018 Framgia. All rights reserved.
//

struct HomeViewModel: ViewModelType {

    struct Input {

    }

    struct Output {

    }

    let navigator: HomeNavigatorType
    let useCase: HomeUseCaseType

    func transform(_ input: Input) -> Output {
        return Output()
    }

}
