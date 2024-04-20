//
//  Apis.swift
//  HealthStaffing
//
//  Created by CTS on 31/01/24.
//

import Foundation
import UIKit

let deviceType = UIDevice.current.userInterfaceIdiom == .pad ? "iPad" : "iPhone"


struct  Urls{

    static let BASE_URL = "https://www.health-staffingnetwork.com/api/"
    
    static let USER_REGISTRATION = BASE_URL + "register.php"
    static let employersUrl =  BASE_URL + "Employers_Form.php"
    static let facilityUrl =  BASE_URL + "Jobseekers_Form.php"
    
    static let LoginUrl = BASE_URL + "emplyoyee_login.php"
    static let ManagerLoginUrl = BASE_URL + "manager_login.php"
    static let ResetPasssword = BASE_URL + "forget_pass.php"
    static let NewForm = BASE_URL + "new_form.php"
    static let TimeSheetList = BASE_URL + "add_timesheet.php"
    static let savedTimeSheet = BASE_URL + "saved_timesheet.php"
    static let savedTimeSheetList = BASE_URL + "saved_timesheet_list.php"
    
    static let SubmitTimeSheet = BASE_URL + "submitted_timesheet.php"
    static let SubmitTimeSheetList = BASE_URL + "submit_timesheet_list.php"
    static let ViewSubmitTimeSheet = BASE_URL + "view_submit_timesheet.php"
    
    static let EmployeeDashboard = BASE_URL + "emp_dashboard.php"
    static let ManagerDashboard = BASE_URL + "man_dashboard.php"
    static let ManagerReviewDetailTS = BASE_URL + "review_details_timesheet.php"
    static let ManagerReview = BASE_URL + "review_timesheet.php"
    static let managerSubmitTimeSheet = BASE_URL + "submit_by_man.php"
    static let managerSubmitTSList = BASE_URL + "submit_timesheet_list_man.php"
    static let managerSubmitTSDetails = BASE_URL + "submit_timesheet_details_man.php"
}


