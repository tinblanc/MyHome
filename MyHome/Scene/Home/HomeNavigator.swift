//
// HomeNavigator.swift
// KnotBuilder
//
// Created by tran.huu.tan on 4/15/18.
// Copyright © 2018 Framgia. All rights reserved.
//

protocol HomeNavigatorType {
    func toHome()
}

struct HomeNavigator: HomeNavigatorType {
    let navigationController: UINavigationController
    let useCaseProvider: UseCaseProviderType
    
    func toHome() {
        let vc = HomeViewController.instantiate()
        let vm = HomeViewModel(navigator: self, useCase: useCaseProvider.makeHomeUseCase())
        vc.bindViewModel(to: vm)
        navigationController.pushViewController(vc, animated: false)
    }
}
