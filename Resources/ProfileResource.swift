//
//  ProfileResource.swift
//  HealthStaffing
//
//  Created by Chawtech on 06/03/24.
//

import Foundation

@available(iOS 15.0, *)
struct ProfileResource {
    
//    func getProfile(request: ProfileRequest, onSuccess:@escaping ( result: ProfileResponse) -> Void, onError:@escaping( error: Error) -> Void){
//
//        do {
//            let requestBody = try JSONEncoder().encode(request)
//            HttpUtility.shared.postRequest(urlString: APIs.GET_USER_PROFILE, requestBody: requestBody, resultType: ProfileResponse.self) { (result) in
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
//    }
    
//    func changePassword(request: ChangePasswordRequest, onSuccess:@escaping ( result: ChangePasswordResponse) -> Void, onError:@escaping( error: Error) -> Void){
//
//        do {
//            let requestBody = try JSONEncoder().encode(request)
//
//            HttpUtility.shared.postRequest(urlString: APIs.CHANGE_PASSWORD, requestBody: requestBody, resultType: ChangePasswordResponse.self) { (result) in
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
    
    func resetPassword(request: ResetPasswordRequest, onSuccess:@escaping (_ result: ResetPasswordResponse) -> Void, onError:@escaping( _ error: Error) -> Void){

        do {
            let requestBody = try JSONEncoder().encode(request)

            HttpUtility.shared.postRequest(urlString: Urls.ResetPasssword, requestBody: requestBody, resultType: ResetPasswordResponse.self) { (result) in
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
