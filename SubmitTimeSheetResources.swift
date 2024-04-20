//
//  SubmitTimeSheetResources.swift
//  HealthStaffing
//
//  Created by Chawtech on 18/03/24.
//

import Foundation

@available(iOS 15.0, *)
struct SubmitTimeSheetResource {
    func submitTimeSheet(request: SubmitTimeSheetRequest, onSuccess:@escaping (_ result: SubmitTimeSheetResponse) -> Void, onError:@escaping(_ error: Error) -> Void){
        do {
            let requestBody = try JSONEncoder().encode(request)

            HttpUtility.shared.postRequest(urlString: Urls.SubmitTimeSheet, requestBody: requestBody, resultType: SubmitTimeSheetResponse.self) { (result) in
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
