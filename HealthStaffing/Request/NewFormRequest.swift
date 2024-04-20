//
//  NewFormRequest.swift
//  HealthStaffing
//
//  Created by Chawtech on 12/03/24.
//

import Foundation

struct NewFormRequest: Encodable {
    let startDate, userID: String?

    enum CodingKeys: String, CodingKey {
        case startDate = "start_date"
        case userID = "user_id"
    }
}


struct ViewSubmitTimeSheetRequest: Encodable {
    let userID, timesheetID: String?
    
    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case timesheetID = "timesheet_id"
    }
}
