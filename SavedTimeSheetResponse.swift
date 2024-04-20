//
//  SavedTimeSheetResponse.swift
//  HealthStaffing
//
//  Created by Chawtech on 14/03/24.
//

import Foundation

struct SavedTimeSheetResponse: Codable {
    let success, status: String?
    let data: SavedTimeSheetData
    let message: String?
}

// MARK: - DataClass
struct SavedTimeSheetData: Codable {
    let userID, timesheetID, save_count: String?

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case timesheetID = "timesheet_id"
        case save_count
    }
}
