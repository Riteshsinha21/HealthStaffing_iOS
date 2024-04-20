//
//  NewFormResponse.swift
//  HealthStaffing
//
//  Created by Chawtech on 12/03/24.
//

import Foundation

struct NewFormResponse: Codable {
    let success, status: String?
    let data: NewFormResponseData?
    let message: String?
}

// MARK: - DataClass
struct NewFormResponseData: Codable {
    let timesheetID: String?
    let datearray: [Datearray]?
    let totalWeekHour: String?
    let saveCount: String?

    
    enum CodingKeys: String, CodingKey {
        case timesheetID = "timesheet_id"
        case datearray
        case totalWeekHour = "total_week_hour"
        case saveCount = "save_count"
    }
}

// MARK: - Datearray
struct Datearray: Codable {
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
