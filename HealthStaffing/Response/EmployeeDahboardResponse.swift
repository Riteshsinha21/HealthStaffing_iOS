//
//  EmployeeDahboardResponse.swift
//  HealthStaffing
//
//  Created by Chawtech on 20/03/24.
//

import Foundation

struct EmployeeDashboardResponse: Codable {
    let success, status: String?
    let data: EmployeeDashboardData?
    let message: String?
}

struct EmployeeDashboardData: Codable {
    let saveCount, submitCount: String?
    let isLogin: Bool?

    enum CodingKeys: String, CodingKey {
        case saveCount = "save_count"
        case submitCount = "submit_count"
        case isLogin = "is_login"
    }
}
