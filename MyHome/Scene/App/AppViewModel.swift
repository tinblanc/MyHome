//
//  AppViewModel.swift
//  MyHome
//
//  Created by Tin Blanc on 4/15/18.
//  Copyright © 2018 Tin Blanc. All rights reserved.
//

import Foundation

struct AppViewModel: ViewModelType {
    struct Input {
        let trigger: Driver<Void>
    }
    
    struct Output {
        let application: Driver<Void>
    }
    
    let navigator: AppNavigatorType
    let useCase: AppUseCaseType
    
    func transform(_ input: Input) -> Output {
        let application = input.trigger
            .do(onNext: { _ in
                self.navigator.toMain()
            })
            .mapToVoid()
        
        return Output(application: application)
    }
}
