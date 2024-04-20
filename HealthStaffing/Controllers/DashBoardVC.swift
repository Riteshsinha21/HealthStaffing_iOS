//
//  DashBoardVC.swift
//  HealthStaffing
//
//  Created by Chawtech on 01/03/24.
//

import UIKit

protocol loginType{
    func passDataHomeToLogin(loginName:String)
}

@available(iOS 15.0, *)
class DashBoardVC: UIViewController {
    
    @IBOutlet weak var savedFormLbl: UILabel!
    @IBOutlet weak var newFormView: UIView!
    
    @IBOutlet weak var savedFormView: UIView!
    
    @IBOutlet weak var submittedFormView: UIView!
    
    @IBOutlet weak var logoutView: UIView!
    
    @IBOutlet weak var welcomeUserLbl: UILabel!
    @IBOutlet weak var submitLbl: UILabel!
    
    var welcomeUser = UserDefaults.standard.getUserName()
    var loginType = "Employee"
    var loginDelegate:loginType?
    
    var dashBoardData:EmployeeDashboardData?
    
        override func viewDidLoad() {
        super.viewDidLoad()
       
        
        
//        let userId = UserDefaults.standard.getUserID()
//        let saveCount = UserDefaults.standard.getsaveCount()
//        let submitCount = UserDefaults.standard.getSubmitCount()
//        self.savedFormLbl.text = saveCount
//        self.submitLbl.text = submitCount
        
        
        if let welcmUser = UserDefaults.standard.getUserName(){
            welcomeUser = welcmUser
            self.welcomeUserLbl.text = "Welcome \(welcmUser)"
        }
        
        self.newFormView.layer.cornerRadius = 20
        self.savedFormView.layer.cornerRadius = 20
        self.submittedFormView.layer.cornerRadius = 20
        
        self.newFormView.layer.borderWidth = 1
        self.savedFormView.layer.borderWidth = 1
        self.submittedFormView.layer.borderWidth = 1
        
        self.newFormView.layer.borderColor = UIColor(red: 0/255, green: 81/255, blue: 132/255, alpha: 1).cgColor
        self.savedFormView.layer.borderColor = UIColor(red: 0/255, green: 81/255, blue: 132/255, alpha: 1).cgColor
        self.submittedFormView.layer.borderColor =  UIColor(red: 0/255, green: 81/255, blue: 132/255, alpha: 1).cgColor
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let userId = UserDefaults.standard.getUserID()
//        self.setData()
        let employeeDashboardRequest = EmployeeDashboardRequest(userID: userId)
        employeeDashboardRequestToServer(request: employeeDashboardRequest)
    }
    
    func setData() {
        let saveCount = UserDefaults.standard.getsaveCount()
        let submitCount = UserDefaults.standard.getSubmitCount()
        self.submitLbl.text = "Submitted Forms - " + (submitCount ?? "")
        self.savedFormLbl.text = "Saved Forms - \(saveCount ?? "")"
    }
    
    
    @IBAction func onClickNewForm(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "NewFormVC") as! NewFormVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func onClickSavedForm(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "SavedForm") as! SavedForm
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func onClickSubmittedForm(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "SubmittedFormVC") as! SubmittedFormVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func onClickBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onClickLogout(_ sender: Any) {
        showAlert()
    }
    
    
    func showAlert(){
        DispatchQueue.main.async {
            //        showLoading()
        }
        
        let alert = UIAlertController(title: "Health Staffing", message: "Are you sure you want to LogOut ?", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action: UIAlertAction!) in
            
            DispatchQueue.main.async {
                //                hideLoading()
            }
            print("Handle Ok logic here")
            UserDefaults.standard.setUserLoggedIn(false)
            UserDefaults.standard.removeObject(forKey:"LOGGED_IN")
            UserDefaults.standard.removeObject(forKey: "EmployeeType")
            //          let userId = UserDefaults.standard.getUserID()
            //            let userName = UserDefaults.standard.getUserName()
            //            let userEmailId = UserDefaults.standard.getEmail()
            //            UserDefaults.standard.removeObject(forKey: userId ?? "")
            UserDefaults.standard.removeObject(forKey: "EMAIL")
            UserDefaults.standard.removeObject(forKey: "user_name")
            
            guard let window = UIApplication.shared.keyWindow else {
                return
            }
            
            self.setupAppropriateScreen()
        }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { (action: UIAlertAction!) in
            DispatchQueue.main.async {
                hideLoading()
            }
            print("Handle Cancel Logic here")
        }))
        present(alert, animated: true, completion: nil)
    }
    
    func setupAppropriateScreen() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainVC") as! MainVC
        self.makeToast("Logout successfully")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func onClickHomeBtn(_ sender: Any) {
        if loginType == "Employee"{
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "MainVC") as! MainVC
            self.navigationController?.pushViewController(vc, animated: true)
            
        }else if loginType == "Manager"{
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "MainVC") as! MainVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else{
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "MainVC") as! MainVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
//  EmployeeDashboardApi
    private func employeeDashboardRequestToServer(request: EmployeeDashboardRequest){
        DispatchQueue.main.async {
            showLoading()
        }
        
        let employeeDashboardResource = EmployeeDashboardResource()
        employeeDashboardResource.employeeDashboard(request: request) { (response) in
            if response.success == "true"{
                hideLoading()
                self.dashBoardData = response.data
//                let saveCount = response.data?.saveCount
//                let submitCount = response.data?.submitCount
                
                print(response)
                DispatchQueue.main.async {
                    let saveCount =   self.dashBoardData?.saveCount
                    let submitCount = self.dashBoardData?.submitCount
                    
                    self.savedFormLbl.text = "Saved Forms - " + (saveCount ?? "")
                    self.submitLbl.text = "Submitted Forms - " + (submitCount ?? "")
            }
            }else{
                DispatchQueue.main.async {
                    hideLoading()
                    self.makeToast(response.message!)
                }
            }
        } onError: { (error) in
            DispatchQueue.main.async {
                hideLoading()
                self.makeToast(error.localizedDescription)
            } }
    }
    
}
