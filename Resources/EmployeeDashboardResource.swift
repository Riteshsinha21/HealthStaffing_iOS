//
//  EmployeeDashboardResource.swift
//  HealthStaffing
//
//  Created by Chawtech on 20/03/24.
//

import Foundation

@available(iOS 15.0, *)
struct EmployeeDashboardResource {
    func employeeDashboard(request: EmployeeDashboardRequest, onSuccess:@escaping (_ result: EmployeeDashboardResponse) -> Void, onError:@escaping(_ error: Error) -> Void){
        do {
            let requestBody = try JSONEncoder().encode(request)
            HttpUtility.shared.postRequest(urlString: Urls.EmployeeDashboard, requestBody: requestBody, resultType: EmployeeDashboardResponse.self) { (result) in
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
