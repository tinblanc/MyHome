//
//  ValidationError.swift
//  MyHome
//
//  Created by Tin Blanc on 7/14/18.
//  Copyright © 2018 Tin Blanc. All rights reserved.
//

enum ValidationError: Error, CustomStringConvertible {
    case email
    case password
    case other(String)
    case confirmPassword
    case sameUsername
    case passwordLength
    case passwordCharacter
    case passwordSpecialCharacter
    case requiredBirthday
    case requiredConfirmCode
    case sameOldPassword
    case emptyPassword
    case specialUsername
    case emptyTitle
    case requireField
    case isNotNumber
    
    var description: String {
        switch self {
        case .email:
            return "validation.email".localized()
        case .password:
            return "validation.password".localized()
        case .other(let message):
            return message
        case .confirmPassword:
            return "validation.confirmPassword".localized()
        case .sameUsername:
            return "validation.sameUsername".localized()
        case .passwordLength:
            return "validation.passwordLength".localized()
        case .passwordCharacter:
            return "validation.passwordCharacter".localized()
        case .passwordSpecialCharacter:
            return "validation.passwordSpecialCharacter".localized()
        case .requiredBirthday:
            return "validation.birthday.required".localized()
        case .requiredConfirmCode:
            return "validation.confirmCode.required".localized()
        case .sameOldPassword:
            return "validation.sameOldPassword".localized()
        case .emptyPassword:
            return "validation.emptyPassword".localized()
        case .specialUsername:
            return "validation.specialUsername".localized()
        case .emptyTitle:
            return "validation.empty".localized()
        case .requireField:
            return "validation.requireField".localized()
        case .isNotNumber:
            return "validation.isNotNumber".localized()
        }
        
    }
}
