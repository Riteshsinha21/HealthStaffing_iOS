//
//  LoginResponse.swift
//  HealthStaffing
//
//  Created by Chawtech on 06/03/24.
//

import Foundation

struct LoginResource{
    func login(request: LoginParams, onSuccess:@escaping (_ result: LoginResponse) -> Void, onError:@escaping(_ error: Error) -> Void){
       
        do {
            let requestBody = try JSONEncoder().encode(request)
            HttpUtility.shared.postRequest(urlString: Urls.LoginUrl, requestBody: requestBody, resultType: LoginResponse.self) { (result) in
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
