//
//  NewFormResources.swift
//  HealthStaffing
//
//  Created by Chawtech on 12/03/24.
//


import Foundation

@available(iOS 15.0, *)
struct NewFormResource
{
    func newForm(request: NewFormRequest, onSuccess:@escaping (_ result: NewFormResponse) -> Void, onError:@escaping(_ error: Error) -> Void){

        do {
            let requestBody = try JSONEncoder().encode(request)

            HttpUtility.shared.postRequest(urlString: Urls.NewForm, requestBody: requestBody, resultType: NewFormResponse.self) { (result) in
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
    
    func ViewSubmitTimeSheet(request: ViewSubmitTimeSheetRequest, onSuccess:@escaping (_ result: NewFormResponse) -> Void, onError:@escaping(_ error: Error) -> Void){

        do {
            let requestBody = try JSONEncoder().encode(request)

            HttpUtility.shared.postRequest(urlString: Urls.ViewSubmitTimeSheet, requestBody: requestBody, resultType: NewFormResponse.self) { (result) in
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
