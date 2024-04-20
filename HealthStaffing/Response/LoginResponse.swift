//
//  LoginResponse.swift
//  HealthStaffing
//
//  Created by Chawtech on 06/03/24.
//

import Foundation

struct LoginResponse: Codable {
    let status: String?
    let success:  String?
    let data: LoginData?
    let message: String?
}

// MARK: - DataClass
struct LoginData: Codable {
    let name: String?
    let userID: Int?
    let email, userRole, save_count, submit_count: String?
    let isLogin: Bool?

    enum CodingKeys: String, CodingKey {
        case name
        case userID = "user_id"
        case email, save_count, submit_count
        case userRole = "user_role"
        case isLogin = "is_login"
    }
}
