//
//  ManagerReviewTimeSheetRequest.swift
//  HealthStaffing
//
//  Created by Chawtech on 21/03/24.
//

import Foundation

// MARK: - Welcome
struct ManagerReviewTimeSheetRequest: Encodable {
    let managerID: String?

    enum CodingKeys: String, CodingKey {
        case managerID = "manager_id"
    }
}
