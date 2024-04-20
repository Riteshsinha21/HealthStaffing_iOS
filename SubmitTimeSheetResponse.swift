//
//  SubmitTimeSheetResponse.swift
//  HealthStaffing
//
//  Created by Chawtech on 18/03/24.
//


import Foundation

struct SubmitTimeSheetResponse: Codable {
    let success, status: String?
    let data: SubmitTimeSheetData?
    let message: String?
}

struct SubmitTimeSheetData: Codable {
    let userID, timesheetID, saveCount, submitCount: String?
    let signature: String?

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case timesheetID = "timesheet_id"
        case saveCount = "save_count"
        case submitCount = "submit_count"
        case signature
    }
}
