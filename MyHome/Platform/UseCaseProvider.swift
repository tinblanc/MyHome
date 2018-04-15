//
//  UseCaseProvider.swift
//  MyHome
//
//  Created by Tin Blanc on 4/15/18.
//  Copyright © 2018 Tin Blanc. All rights reserved.
//

import UIKit

struct UseCaseProvider: UseCaseProviderType {
    func makeHomeUseCase() -> HomeUseCaseType {
        return HomeUseCase()
    }
}
