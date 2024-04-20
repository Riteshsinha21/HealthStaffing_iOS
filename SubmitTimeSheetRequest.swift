//
//  SubmitTimeSheetRequest.swift
//  HealthStaffing
//
//  Created by Chawtech on 18/03/24.
//

import Foundation


struct SubmitTimeSheetRequest: Encodable {
    let userID, timesheetID, signature: String?

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case timesheetID = "timesheet_id"
        case signature
    }
}
