//
//  SavedTimeSheetListRequest.swift
//  HealthStaffing
//
//  Created by Chawtech on 14/03/24.
//

import Foundation

struct SavedTimeSheetListRequest: Encodable {
    let userID: String?

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
    }
}
