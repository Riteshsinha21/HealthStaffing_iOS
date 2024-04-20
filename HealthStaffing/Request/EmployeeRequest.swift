//
//  EmployeeRequest.swift
//  HealthStaffing
//
//  Created by CTS on 14/02/24.
//

import Foundation

struct EmployersRequest: Encodable {
    let fullName, companyName, positionInTheCompany, companyAddress: String?
    let city, state, zipCode, emailAddress: String?
    let countryCode, phoneNumber, preferToBeContactedBy, bestTimeToCall: String?
    let preferredDate, preferredTime, staffingRequestDetails, additionalInformation: String?

    enum CodingKeys: String, CodingKey {
        case fullName = "Full_Name"
        case companyName = "Company_Name"
        case positionInTheCompany = "Position_In_The_Company"
        case companyAddress = "Company_Address"
        case city = "City"
        case state = "State"
        case zipCode = "Zip_Code"
        case emailAddress = "Email_Address"
        case countryCode = "country_code"
        case phoneNumber = "Phone_number"
        case preferToBeContactedBy = "Prefer_to_be_contacted_by"
        case bestTimeToCall = "Best_Time_To_Call"
        case preferredDate = "Preferred_Date"
        case preferredTime = "Preferred_Time"
        case staffingRequestDetails = "Staffing_Request_Details"
        case additionalInformation = "Additional_Information"
    }
}
