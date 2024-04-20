//
//  EmployeeDashboardRequest.swift
//  HealthStaffing
//
//  Created by Chawtech on 20/03/24.
//

import Foundation

struct EmployeeDashboardRequest: Codable {
    let userID: String?

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
    }
}
