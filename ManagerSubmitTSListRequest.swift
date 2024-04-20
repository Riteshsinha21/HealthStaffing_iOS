//
//  ManagerSubmitTSListRequest.swift
//  HealthStaffing
//
//  Created by Chawtech on 22/03/24.
//

import Foundation

struct ManagerSubmitTSListRequest: Encodable {
    let managerID: String?

    enum CodingKeys: String, CodingKey {
        case managerID = "manager_id"
    }
}
