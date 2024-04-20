//
//  SavedTimeSheetRequest.swift
//  HealthStaffing
//
//  Created by Chawtech on 14/03/24.
//


import Foundation

struct SavedTimeSheetRequest: Encodable {
    let userID, timesheetID: String?

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case timesheetID = "timesheet_id"
    }
}
