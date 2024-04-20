//
//  TimeSheetListingResponse.swift
//  HealthStaffing
//
//  Created by Chawtech on 11/03/24.
//

import Foundation
struct TimeSheetListingResponse: Codable {
    let success, status: String?
    let data: timeSheetListData
    let message: String?
}

struct timeSheetListData: Codable {
    let date, day, startTime, outTime: String?
    let regularHours, lunchHours, overtimeHours, totalHour: String?

    enum CodingKeys: String, CodingKey {
        case date, day
        case startTime = "Start_Time"
        case outTime = "Out_Time"
        case regularHours = "Regular_Hours"
        case lunchHours = "Lunch_Hours"
        case overtimeHours = "Overtime_Hours"
        case totalHour = "total_hour"
    }
}
