//
//  FacilityResponse.swift
//  HealthStaffing
//
//  Created by CTS on 20/02/24.
//



import Foundation

struct FacilityResponse: Codable {
    let success, status: String?
    let data: DataClass?
    let message: String?
}

// MARK: - DataClass
struct DataClass: Codable {
    let jobApplyingFor, firstName, middleInitial, lastName: String?
    let socialSecurityNumber, dateOfBirth, address, city: String?
    let state, zipcode, phoneNumber, emailAddress: String?
    let maritalStatus, education, employmentTypeDesired, daysAvailableToWork: String?
    let numberOfHoursAvailableToWork, availableToWorkOvertime, skills, dateToStartWork: String?
    let desiredSalary, fileName: String?

    enum CodingKeys: String, CodingKey {
        case jobApplyingFor = "Job Applying for"
        case firstName = "First Name"
        case middleInitial = "Middle Initial"
        case lastName = "Last Name"
        case socialSecurityNumber = "Social Security Number"
        case dateOfBirth = "Date of Birth"
        case address = "Address"
        case city = "City"
        case state = "State"
        case zipcode = "Zipcode"
        case phoneNumber = "Phone Number"
        case emailAddress = "Email Address"
        case maritalStatus = "Marital Status"
        case education = "Education"
        case employmentTypeDesired = "Employment Type Desired"
        case daysAvailableToWork = "Days Available to Work"
        case numberOfHoursAvailableToWork = "Number of Hours Available to Work"
        case availableToWorkOvertime = "Available to work overtime"
        case skills = "Skills"
        case dateToStartWork = "Date to start work"
        case desiredSalary = "Desired Salary"
        case fileName = "file_name"
    }
}
