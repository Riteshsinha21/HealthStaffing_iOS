//
//  ManagerReviewDetailTSResources.swift
//  HealthStaffing
//
//  Created by Chawtech on 21/03/24.
//

import Foundation


@available(iOS 15.0, *)
struct ManagerReviewDetailTSResource {
    func ManagerReviewDetailTS(request: ManagerReviewDetailTSRequest, onSuccess:@escaping (_ result: ManagerReviewDetailsTSResponse) -> Void, onError:@escaping(_ error: Error) -> Void){
        do {
            let requestBody = try JSONEncoder().encode(request)
            HttpUtility.shared.postRequest(urlString: Urls.ManagerReviewDetailTS, requestBody: requestBody, resultType: ManagerReviewDetailsTSResponse.self) { (result) in
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

@available(iOS 15.0, *)
struct ManagerSubmittedDetailTSResource {
    func ManagerSubmitDetailTS(request: ManagerSubmitFormDetailTSRequest, onSuccess:@escaping (_ result: ManagerReviewDetailsTSResponse) -> Void, onError:@escaping(_ error: Error) -> Void){
        do {
            let requestBody = try JSONEncoder().encode(request)
            HttpUtility.shared.postRequest(urlString: Urls.managerSubmitTSDetails, requestBody: requestBody, resultType: ManagerReviewDetailsTSResponse.self) { (result) in
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
