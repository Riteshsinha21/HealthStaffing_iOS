//
//  SavedTimeSheetListResponse.swift
//  HealthStaffing
//
//  Created by Chawtech on 14/03/24.
//

import Foundation

struct SavedTimeSheetListResponse: Codable {
    let success, status: String?
    let data: [SavedTimeSheetListData]
    let message: String?
}

struct SavedTimeSheetListData: Codable {
    let timesheetID, startDate, endDate, totalHour: String?
    enum CodingKeys: String, CodingKey {
        case timesheetID = "Timesheet_id"
        case startDate = "Start_date"
        case endDate = "End_date"
        case totalHour = "total_hour"
    }
}
