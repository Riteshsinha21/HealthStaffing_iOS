//
//  ManagerReviewTimeSheetResponse.swift
//  HealthStaffing
//
//  Created by Chawtech on 21/03/24.
//

import Foundation


// MARK: - Welcome
struct ManagerReviewTimeSheetResponse: Codable {
    let success, status: String?
    let data: [ManagerReviewTimeSheetData]
    let message: String?
}

// MARK: - Datum
struct ManagerReviewTimeSheetData: Codable {
    let timesheetID, employeeID, employeeName, companyName: String?
    let startDate, endDate, totalHour: String?

    enum CodingKeys: String, CodingKey {
        case timesheetID = "Timesheet_id"
        case employeeID = "employee_id"
        case employeeName = "Employee_name"
        case companyName = "Company_name"
        case startDate = "Start_date"
        case endDate = "End_date"
        case totalHour = "total_hour"
    }
}
