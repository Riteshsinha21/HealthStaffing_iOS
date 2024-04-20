//
//  HTTPError.swift
//  HealthStaffing
//
//  Created by CTS on 31/01/24.
//


import Foundation

enum HTTPError: HealthStaffingError, LocalizedError {
    case incorrectData
    case badRequest
    case internetConnection
    
    var errorDescription: String?{
        switch self {
        case .incorrectData:
            return NSLocalizedString("Something bad happened on server side", comment: "")
        case .badRequest:
            return NSLocalizedString("Bad Request", comment: "")
        case .internetConnection:
            return NSLocalizedString("No Internet Connection", comment: "")
        }
    }
    
}
