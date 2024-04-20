//
//  TimeSheetResources.swift
//  HealthStaffing
//
//  Created by Chawtech on 12/03/24.
//



import Foundation
@available(iOS 15.0, *)
struct TimeSheetResource {

    func timeSheet(request: TimeSheetListRequest, onSuccess:@escaping (_ result: TimeSheetListingResponse) -> Void, onError:@escaping(_ error: Error) -> Void){

        do {
            let requestBody = try JSONEncoder().encode(request)

            HttpUtility.shared.postRequest(urlString: Urls.TimeSheetList, requestBody: requestBody, resultType: TimeSheetListingResponse.self) { (result) in
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
