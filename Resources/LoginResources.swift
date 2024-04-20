//
//  LoginResources.swift
//  HealthStaffing
//
//  Created by Chawtech on 06/03/24.
//

import Foundation

//@available(iOS 15.0, *)
//struct LoginResource{
//    func login(request: LoginParams, urlString: String, onSuccess:@escaping (_ result: LoginResponse) -> Void, onError:@escaping(_ error: Error) -> Void){
//
//        do {
//            let requestBody = try JSONEncoder().encode(request)
//            HttpUtility.shared.postRequest(urlString: urlString, requestBody: requestBody, resultType: LoginResponse.self) { (result) in
//                switch result{
//                case .success(let response):
//                    onSuccess(response)
//                case .failure(let error):
//                    onError(error)
//                }
//            }
//        } catch let error {
//            onError(error)
//        }
//
//    }
//
//}
//

struct LoginResource{
    func employeeLogin(request: LoginParams, onSuccess:@escaping (_ result: LoginResponse) -> Void, onError:@escaping(_ error: Error) -> Void){
        do {
            let requestBody = try JSONEncoder().encode(request)
            if #available(iOS 15.0, *) {
                HttpUtility.shared.postRequest(urlString: Urls.LoginUrl, requestBody: requestBody, resultType: LoginResponse.self) { (result) in
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
    
    
    
    func managerLogin(request: LoginParams, onSuccess:@escaping (_ result: ManagerLoginResponse) -> Void, onError:@escaping(_ error: Error) -> Void){
       
        do {
            let requestBody = try JSONEncoder().encode(request)
            if #available(iOS 15.0, *) {
                HttpUtility.shared.postRequest(urlString: Urls.ManagerLoginUrl, requestBody: requestBody, resultType: ManagerLoginResponse.self) { (result) in
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
