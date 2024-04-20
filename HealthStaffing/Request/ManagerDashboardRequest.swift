//
//  ManagerDashboardRequest.swift
//  HealthStaffing
//
//  Created by Chawtech on 20/03/24.
//

import Foundation

struct ManagerDashboardRequest: Codable {
    let managerID: String?

    enum CodingKeys: String, CodingKey {
        case managerID = "manager_id"
    }
}
