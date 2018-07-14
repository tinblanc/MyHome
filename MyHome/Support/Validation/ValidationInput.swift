//
//  ValidationInput.swift
//  MyHome
//
//  Created by Tin Blanc on 7/14/18.
//  Copyright © 2018 Tin Blanc. All rights reserved.
//

import Foundation

class ValidationInput {
    
    private init() {
        
    }
    
    static let shared = ValidationInput()
    
    func validate(username: String) -> ValidationResult {
        var usernameRules = ValidationRuleSet<String>()
        
        let emptyRule = ValidationRequireRule(
            error: ValidationError.requireField)
        usernameRules.add(rule: emptyRule)
        
//        let specialRule = ValidationUsernameRule(error: ValidationError.specialUsername)
//        usernameRules.add(rule: specialRule)
        
//        let emailRule = ValidationRulePattern(
//            pattern: EmailValidationPatternEx.special,
//            error: ValidationError.email)
//        usernameRules.add(rule: emailRule)
        
        return username.validate(rules: usernameRules)
    }
    
    func validate(loginPassword: String) -> ValidationResult {
        
        if loginPassword.isEmpty {
            return ValidationResult.invalid([ValidationError.emptyPassword])
        }
        
        return ValidationResult.valid
    }
    
    func validate(password: String) -> ValidationResult {
        var passwordRules = ValidationRuleSet<String>()
        
        let emptyRule = ValidationRequireRule(
            error: ValidationError.emptyPassword)
        passwordRules.add(rule: emptyRule)
        
        let lengthRule = ValidationRuleLength(
            min: 8, max: 20,
            lengthType: ValidationRuleLength.LengthType.characters, error: ValidationError.passwordLength)
        passwordRules.add(rule: lengthRule)
        
        let requireAtLeastOneNumberAndCapitalLetterRule = ValidationPasswordRequireAtLeastOneNumberAndCapitalLetterRule(
            error: ValidationError.passwordCharacter)
        passwordRules.add(rule: requireAtLeastOneNumberAndCapitalLetterRule)
        
        let passwordSpecialCharacter = ValidationSpecialCharacterRule(
            error: ValidationError.passwordSpecialCharacter)
        passwordRules.add(rule: passwordSpecialCharacter)
        
        return password.validate(rules: passwordRules)
    }
    
    func nameValidate(name: String) -> ValidationResult {
        var titleRules = ValidationRuleSet<String>()
        
        let emptyRule = ValidationRequireRule(
            error: ValidationError.emptyTitle)
        titleRules.add(rule: emptyRule)
        
        return name.validate(rules: titleRules)
    }
    
    func priceValidate(price: String) -> ValidationResult {
        var titleRules = ValidationRuleSet<String>()
        
        let emptyRule = ValidationRequireRule(
            error: ValidationError.emptyTitle)
        titleRules.add(rule: emptyRule)
        
        return price.validate(rules: titleRules)
    }
}

// MARK: - ========== ValidationPasswordRule ==============
struct ValidationPasswordRequireAtLeastOneNumberAndCapitalLetterRule: ValidationRule {
    typealias InputType = String
    
    var error: Error
    
    func validate(input: String?) -> Bool {
        let numberRegEx  = ".*[0-9]+.*"
        let regexNumberText = NSPredicate(format:"SELF MATCHES %@", numberRegEx)
        guard regexNumberText.evaluate(with: input) else { return false }
        
        let capitalLetterRegEx  = ".*[A-Z]+.*"
        let regexCapitalText = NSPredicate(format:"SELF MATCHES %@", capitalLetterRegEx)
        guard regexCapitalText.evaluate(with: input) else { return false }
        
        let lowerLetterRegEx = ".*[a-z]+.*"
        let regexLowerText = NSPredicate(format:"SELF MATCHES %@", lowerLetterRegEx)
        guard regexLowerText.evaluate(with: input) else { return false }
        
        return true
    }
}

struct ValidationPasswordRequireAtLeastOneNumberRule: ValidationRule {
    typealias InputType = String
    
    var error: Error
    
    func validate(input: String?) -> Bool {
        let numberRegEx = ".*[0-9]+.*"
        let regexText = NSPredicate(format:"SELF MATCHES %@", numberRegEx)
        let result = regexText.evaluate(with: input)
        return result
    }
}

struct ValidationSpecialCharacterRule: ValidationRule {
    typealias InputType = String
    
    var error: Error
    
    func validate(input: String?) -> Bool {
        
        // Check Have Space
        if input?.containsWhitespace == true {
            return false
        }
        
        let specialCharacterRegEx  = "^[A-Za-z0-9.\" @ # $ % & ' ( ) ! * + , - . / : ; < = >\"@#$%&'()*+,-./:;<=>!]+$"
        let regexText = NSPredicate(format:"SELF MATCHES %@", specialCharacterRegEx)
        let result = regexText.evaluate(with: input)
        return result
    }
}

struct ValidationRequireRule: ValidationRule {
    typealias InputType = String
    
    var error: Error
    
    func validate(input: String?) -> Bool {
        if input?.isEmpty == true {
            return false
        }
        return true
    }
}
