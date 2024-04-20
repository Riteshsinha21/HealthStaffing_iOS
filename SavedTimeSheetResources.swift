//
//  SavedTimeSheetResources.swift
//  HealthStaffing
//
//  Created by Chawtech on 14/03/24.
//

import Foundation
@available(iOS 15.0, *)
struct SavedTimeSheetResource {
    func savedTimeSheet(request: SavedTimeSheetRequest, onSuccess:@escaping (_ result: SavedTimeSheetResponse) -> Void, onError:@escaping(_ error: Error) -> Void){
        do {
            let requestBody = try JSONEncoder().encode(request)

            HttpUtility.shared.postRequest(urlString: Urls.savedTimeSheet, requestBody: requestBody, resultType: SavedTimeSheetResponse.self) { (result) in
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
