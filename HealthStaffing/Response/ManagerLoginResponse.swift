//
//  ManagerLoginResponse.swift
//  HealthStaffing
//
//  Created by Chawtech on 20/03/24.
//

import Foundation

struct ManagerLoginResponse: Codable {
    let success, status: String?
    let data: ManagerLoginData
    let message: String?
}

struct ManagerLoginData: Codable {
    let name: String?
    let managerID: Int?
    let email, userRole, reviewCount, submitCount: String?
    let isLogin: Bool?

    enum CodingKeys: String, CodingKey {
        case name
        case managerID = "manager_id"
        case email
        case userRole = "user_role"
        case reviewCount = "review_count"
        case submitCount = "submit_count"
        case isLogin = "is_login"
    }
}
