//
//  ManagerReviewDetailsTSResponse.swift
//  HealthStaffing
//
//  Created by Chawtech on 21/03/24.
//

import Foundation

struct ManagerReviewDetailsTSResponse: Codable {
    let success, status: String?
    let data: ManagerReviewDetailData?
    let message: String?
}

// MARK: - DataClass
struct ManagerReviewDetailData: Codable {
    let timesheetID, employeeID: String?
    let datearray: [ManagerReviewDetailArray]?
    let totalWeekHour: String?

    enum CodingKeys: String, CodingKey {
        case timesheetID = "timesheet_id"
        case employeeID = "employee_id"
        case datearray
        case totalWeekHour = "total_week_hour"
    }
}

// MARK: - Datearray
struct ManagerReviewDetailArray: Codable {
    let date, day, startTime, outTime: String?
    let regularHours, lunchHours, overtimeHours, totalHours: String?

    enum CodingKeys: String, CodingKey {
        case date = "Date"
        case day = "Day"
        case startTime = "Start_Time"
        case outTime = "Out_Time"
        case regularHours = "Regular_Hours"
        case lunchHours = "Lunch_Hours"
        case overtimeHours = "Overtime_Hours"
        case totalHours = "Total_Hours"
    }
}
