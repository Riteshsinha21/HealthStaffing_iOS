//
//  ManagerDashboardResponse.swift
//  HealthStaffing
//
//  Created by Chawtech on 20/03/24.
//

import Foundation

 struct ManagerDashboardResponse: Codable {
    let success, status: String?
    let data: ManagerDashboardData?
    let message: String?
}


struct ManagerDashboardData: Codable {
    let reviewCount, submitCount: String?
    let isLogin: Bool?

    enum CodingKeys: String, CodingKey {
        case reviewCount = "review_count"
        case submitCount = "submit_count"
        case isLogin = "is_login"
    }
}
