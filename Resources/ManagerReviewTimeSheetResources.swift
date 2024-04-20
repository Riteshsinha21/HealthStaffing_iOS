//
//  ManagerReviewTimeSheetResources.swift
//  HealthStaffing
//
//  Created by Chawtech on 21/03/24.
//

import Foundation
struct ManagerReviewTimeSheetResources{
    func ManagerReviewTimeSheet(request: ManagerReviewTimeSheetRequest, onSuccess:@escaping (_ result: ManagerReviewTimeSheetResponse) -> Void, onError:@escaping(_ error: Error) -> Void){
        do {
            let requestBody = try JSONEncoder().encode(request)
            if #available(iOS 15.0, *) {
                HttpUtility.shared.postRequest(urlString: Urls.ManagerReview, requestBody: requestBody, resultType: ManagerReviewTimeSheetResponse.self) { (result) in
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
