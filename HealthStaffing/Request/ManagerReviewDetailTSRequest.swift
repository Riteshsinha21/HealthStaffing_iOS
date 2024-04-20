//
//  ManagerReviewDetailTSRequest.swift
//  HealthStaffing
//
//  Created by Chawtech on 21/03/24.
//

import Foundation

struct ManagerReviewDetailTSRequest: Encodable {
    let managerID, employeeID, timesheetID: String?

    enum CodingKeys: String, CodingKey {
        case managerID = "manager_id"
        case employeeID = "employee_id"
        case timesheetID = "timesheet_id"
    }
}

struct ManagerSubmitFormDetailTSRequest: Encodable {
    let employeeID, timesheetID: String?

    enum CodingKeys: String, CodingKey {
        case employeeID = "employee_id"
        case timesheetID = "timesheet_id"
    }
}
