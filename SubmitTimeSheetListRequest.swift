//
//  SubmitTimeSheetListRequest.swift
//  HealthStaffing
//
//  Created by Chawtech on 18/03/24.
//



import Foundation

struct SubmitTimeSheetListRequest: Encodable {
    let userID: String?

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
    }
}
