//
//  LoginValidation.swift
//  HealthStaffing
//
//  Created by Chawtech on 06/03/24.
//

import Foundation

struct LoginValidation{
    
    func validate(request: LoginParams) -> ValidationResult{
        
        let emptyResult = checkFoEmpty(request: request)
        if emptyResult.isEmpty == true{
            return ValidationResult(success: false, error: emptyResult.error)
        }

        return ValidationResult(success: true, error: nil)
    }
    
    
    private func checkFoEmpty(request: LoginParams) -> (isEmpty: Bool, error: RegistrationError?){
        
        if request.login!.isEmpty{
            return (true, RegistrationError.emptyName)
        }
        
        if request.password!.isEmpty{
            return (true, RegistrationError.emptyPassword)
        }
        
        return (false, nil)
            }
    
    private func checkForValidData(request: LoginParams) -> (isValid: Bool, error: RegistrationError?) {
        
        if !request.login!.isValidEmail(){
            return (false, RegistrationError.invalidEmail)
        }
        
        if !request.password!.isValidPassword(){
            return (false, RegistrationError.invalidPassword)
        }
        
        return (true, nil)
        
    }
}
