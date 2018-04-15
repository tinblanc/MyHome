//
//  AppNavigator.swift
//  MyHome
//
//  Created by Tin Blanc on 4/15/18.
//  Copyright © 2018 Tin Blanc. All rights reserved.
//

import Foundation

protocol AppNavigatorType {
    func toMain()
}

struct AppNavigator: AppNavigatorType {
    
    let window: UIWindow
    let useCaseProvider: UseCaseProviderType
    
    var navigationController: UINavigationController? {
        return window.rootViewController?.topMostViewController()?.navigationController
    }
    
    func toMain() {
        let mainNavigator = MainNavigator(useCaseProvider: useCaseProvider, window: window)
        mainNavigator.toMain()
    }
}
