//
//  RegistrationError.swift
//  HealthStaffing
//
//  Created by CTS on 31/01/24.
//


import Foundation
enum RegistrationError: HealthStaffingError, LocalizedError{
    case emptyName
    case emptyEmail
    case emptyPhone
    case emptyPassword
    case emptyConfirmPassword
    case invalidEmail
    case invalidPassword
    case matchPasswords
    case emptyLocation
    case emptyMessage
    
    var errorDescription: String?{
        switch self {
        case .emptyEmail:
            return NSLocalizedString("Please enter email", comment: "")
        case .emptyPassword:
            return NSLocalizedString("Please enter password", comment: "")
        case .invalidEmail:
            return NSLocalizedString("Please enter valid email", comment: "")
        case .invalidPassword:
            return NSLocalizedString("Password must be of minimum 6 characters", comment: "")
        case .emptyName:
            return NSLocalizedString("Please enter name", comment: "")
        case .emptyPhone:
            return NSLocalizedString("Please enter phone number", comment: "")
        case .emptyConfirmPassword:
            return NSLocalizedString("Please enter confirm password", comment: "")
        case .matchPasswords:
            return NSLocalizedString("Passwords do not match", comment: "")
        case .emptyLocation:
            return NSLocalizedString("Please enter location", comment: "")
        case .emptyMessage:
            return NSLocalizedString("Please enter a message", comment: "")
        }
    }
}
