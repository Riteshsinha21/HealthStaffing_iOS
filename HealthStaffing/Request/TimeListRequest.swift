//
//  TimeListRequest.swift
//  HealthStaffing
//
//  Created by Chawtech on 11/03/24.
//

import Foundation

struct TimeSheetListRequest: Encodable {
    let userID, timesheetID, date, day: String?
    let startTime, outTime, regularHours, lunchHours: String?
    let overtimeHours, totalHour: String?

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case timesheetID = "timesheet_id"
        case date, day
        case startTime = "start_time"
        case outTime = "out_time"
        case regularHours = "regular_hours"
        case lunchHours = "lunch_hours"
        case overtimeHours = "overtime_hours"
        case totalHour = "total_hour"
    }
    
}



    
