//
//  ManagerSubmitTSListResponse.swift
//  HealthStaffing
//
//  Created by Chawtech on 22/03/24.
//

import Foundation



// MARK: - Welcome
struct ManagerSubmitTSListResponse: Codable {
    let success, status: String?
    let data: [ManagerSubmitTSListData]
    let message: String?
}

// MARK: - Datum
struct ManagerSubmitTSListData: Codable {
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
