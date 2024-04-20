//
//  EmployersResponse.swift
//  HealthStaffing
//
//  Created by CTS on 14/02/24.
//

import Foundation
//struct EmployeeResponse: Codable {
//    let success, status, message: String
//}

struct EmployeeResponse: Codable {
    let success, status: String?
    let data: EmployeeResponseData?
    let message: String?
}

// MARK: - DataClass
struct EmployeeResponseData: Codable {
    let fullName, companyName, positionInTheCompany, companyAddress: String?
    let city, state, zipCode, emailAddress: String?
    let countryCode, phoneNumber, preferToBeContactedBy, bestTimeToCall: String?
    let preferredDate, preferredTime, staffingRequestDetails, additionalInformation: String?

    enum CodingKeys: String, CodingKey {
        case fullName = "Full Name"
        case companyName = "Company Name"
        case positionInTheCompany = "Position In The Company"
        case companyAddress = "Company Address"
        case city = "City"
        case state = "State"
        case zipCode = "Zip Code"
        case emailAddress = "Email Address"
        case countryCode = "country code"
        case phoneNumber = "Phone number"
        case preferToBeContactedBy = "Prefer to be contacted by"
        case bestTimeToCall = "Best Time To Call"
        case preferredDate = "Preferred Date"
        case preferredTime = "Preferred Time"
        case staffingRequestDetails = "Staffing Request Details"
        case additionalInformation = "Additional Information"
    }
   
}
