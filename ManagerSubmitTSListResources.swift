//
//  ManagerSubmitTSListResources.swift
//  HealthStaffing
//
//  Created by Chawtech on 22/03/24.
//

import Foundation

struct ManagerSubmitTSListResources{
    func ManagerSubmitTSList(request: ManagerSubmitTSListRequest, onSuccess:@escaping (_ result: ManagerSubmitTSListResponse) -> Void, onError:@escaping(_ error: Error) -> Void){
        do {
            let requestBody = try JSONEncoder().encode(request)
            if #available(iOS 15.0, *) {
                HttpUtility.shared.postRequest(urlString: Urls.managerSubmitTSList, requestBody: requestBody, resultType: ManagerSubmitTSListResponse.self) { (result) in
                    switch result{
                    case .success(let response):
                        onSuccess(response)
                    case .failure(let error):
                        onError(error)
                    }
                }
            } else {
            }
        } catch let error {
            onError(error)
        }
    }
    
}
