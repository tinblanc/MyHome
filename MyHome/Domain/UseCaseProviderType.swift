//
//  UseCaseProviderType.swift
//  MyHome
//
//  Created by Tin Blanc on 4/15/18.
//  Copyright © 2018 Tin Blanc. All rights reserved.
//

import UIKit

protocol UseCaseProviderType {
    // Home
    func makeHomeUseCase() -> HomeUseCaseType
    
}
