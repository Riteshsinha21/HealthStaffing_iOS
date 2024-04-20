//
//  ManagerDashboardResources.swift
//  HealthStaffing
//
//  Created by Chawtech on 20/03/24.
//

import Foundation

@available(iOS 15.0, *)
struct ManagerDashboardResource {
    func managerDashboard(request: ManagerDashboardRequest, onSuccess:@escaping (_ result: ManagerDashboardResponse) -> Void, onError:@escaping(_ error: Error) -> Void){
        do {
            let requestBody = try JSONEncoder().encode(request)
            HttpUtility.shared.postRequest(urlString: Urls.ManagerDashboard, requestBody: requestBody, resultType: ManagerDashboardResponse.self) { (result) in
                switch result{
                case .success(let response):
                    onSuccess(response)
                case .failure(let error):
                    onError(error)
                }
            }
        } catch let error {
            onError(error)
        }
    }
}
