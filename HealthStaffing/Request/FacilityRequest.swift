//
//  FacilityRequest.swift
//  HealthStaffing
//
//  Created by CTS on 20/02/24.
//

import Foundation

struct FacilityRequest: Encodable {
    let jobApplyingFor, firstName, middleInitial, lastName: String?
    let socialSecurityNumber, dateOfBirth, address, city: String?
    let state, zipcode, phoneNumber, emailAddress: String?
    let maritalStatus, education, employmentTypeDesired, daysAvailableToWork: String?
    let numberOfHoursAvailableToWork, availableToWorkOvertime, skills, dateToStartWork: String?
    let desiredSalary, attachment: String?

    enum CodingKeys: String, CodingKey {
        case jobApplyingFor = "Job_Applying_for"
        case firstName = "First_Name"
        case middleInitial = "Middle_Initial"
        case lastName = "Last_Name"
        case socialSecurityNumber = "Social_Security_Number"
        case dateOfBirth = "Date_of_Birth"
        case address = "Address"
        case city = "City"
        case state = "State"
        case zipcode = "Zipcode"
        case phoneNumber = "Phone_Number"
        case emailAddress = "email_address"
        case maritalStatus = "Marital_Status"
        case education = "Education"
        case employmentTypeDesired = "Employment_Type_Desired"
        case daysAvailableToWork = "Days_Available_to_Work"
        case numberOfHoursAvailableToWork = "Number_of_Hours_Available_to_Work"
        case availableToWorkOvertime = "Available_to_work_overtime"
        case skills = "Skills"
        case dateToStartWork = "Date_to_start_work"
        case desiredSalary = "Desired_Salary"
        case attachment = "attachment"
    }
}
