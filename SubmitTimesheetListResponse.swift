//
//  SubmitTimesheetListResponse.swift
//  HealthStaffing
//
//  Created by Chawtech on 18/03/24.
//



import Foundation

// MARK: - Welcome
struct SubmitTimeSheetListResponse: Codable {
    let success, status: String?
    let data: [SubmitTimeSheetListData]
    let message: String?
}

struct SubmitTimeSheetListData: Codable {
    let timesheetID, startDate, endDate, totalHour: String?
    let status: String?

    enum CodingKeys: String, CodingKey {
        case timesheetID = "Timesheet_id"
        case startDate = "Start_date"
        case endDate = "End_date"
        case totalHour = "total_hour"
        case status
    }
    
    
}
