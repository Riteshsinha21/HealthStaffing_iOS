//
//  Userdefaults.swift
//  HealthStaffing
//
//  Created by Chawtech on 07/03/24.
//

import Foundation
extension UserDefaults{
    func setSubmitCount(submitCount: String){
        UserDefaults.standard.set(submitCount, forKey: "submit_count")
    }
    
    func getSubmitCount() -> String?{
        return UserDefaults.standard.value(forKey: "submit_count") as? String
    }
    
    
    func setSaveCount(saveCount: String){
        UserDefaults.standard.set(saveCount, forKey: "save_count")
    }
    
    func getsaveCount() -> String?{
        return UserDefaults.standard.value(forKey: "save_count") as? String
    }
    
    
    
    func setUserLoggedIn(_ bool: Bool){
        UserDefaults.standard.set(bool, forKey: "LOGGED_IN")
    }
    
    func saveUserID(userID: String){
        UserDefaults.standard.set(userID, forKey: "USER_ID")
    }
    
    func getUserID() -> String?{
        return UserDefaults.standard.value(forKey: "USER_ID") as? String
    }
    
    func saveUserName(userName: String){
        UserDefaults.standard.set(userName , forKey: "user_name")
    }
    
    func getUserName() -> String?{
        return UserDefaults.standard.value(forKey: "user_name") as? String
    }
    
    func saveEmail(email: String){
        UserDefaults.standard.set(email, forKey: "EMAIL")
    }
    
    func getEmail() -> String?{
        return UserDefaults.standard.value(forKey: "EMAIL") as? String
    }
    
    func saveUserRole(userRole: String){
        UserDefaults.standard.set(userRole, forKey: "user_role")
    }
    
    func saveEmployeeType(EmpType: String){
        UserDefaults.standard.set(EmpType, forKey: "EmployeeType")
    }
    
    func getUserRole() -> String?{
        return UserDefaults.standard.value(forKey: "user_role") as? String
    }
    
    func getEmployeeType() -> String?{
        return UserDefaults.standard.value(forKey: "EmployeeType") as? String
    }
    
    func saveManagerUserRole(managerRole: String){
        UserDefaults.standard.set(managerRole, forKey: "Manager")
    }
    
    func getManagerUserRole() -> String?{
        return UserDefaults.standard.value(forKey: "Manager") as? String
    }
    
    func setIsClearSign(_ bool: Bool){
        UserDefaults.standard.set(bool, forKey: "isClear")
    }
    
    func getIsClearSign() -> Bool?{
        return UserDefaults.standard.value(forKey: "isClear") as? Bool
    }
    
    func isUserLoggedIn() -> Bool{
        if let isUserLoggedIn: Bool = UserDefaults.standard.value(forKey: "LOGGED_IN") as? Bool{
            return isUserLoggedIn
        }else{
            return false
        }
    }
}
