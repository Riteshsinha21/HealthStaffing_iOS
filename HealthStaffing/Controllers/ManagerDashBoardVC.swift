//
//  ManagerDashBoardVC.swift
//  HealthStaffing
//
//  Created by Chawtech on 07/03/24.
//

import UIKit
@available(iOS 15.0, *)
class ManagerDashBoardVC: UIViewController {
    
    @IBOutlet weak var savedFormView: UIView!
    
    @IBOutlet weak var submittedFormView: UIView!
    
    @IBOutlet weak var welcomeUserLbl: UILabel!
    
    
    @IBOutlet weak var submitLbl: UILabel!
    
    
    @IBOutlet weak var reviewLbl: UILabel!
    
    var welcomeUser = ""
    
    var managerDashBoardData: ManagerDashboardData?
    override func viewDidLoad() {
        super.viewDidLoad()
        let managerId = UserDefaults.standard.getUserID()
        let managerDashboardRequest = ManagerDashboardRequest(managerID: managerId)
        managerDashboardRequestToServer(request: managerDashboardRequest)
        
        
        if let welcmUser = UserDefaults.standard.getUserName(){
         welcomeUser = welcmUser
        self.welcomeUserLbl.text = "Welcome \(welcmUser)"
    }
      
        self.savedFormView.layer.cornerRadius = 20
        self.submittedFormView.layer.cornerRadius = 20
       
        self.savedFormView.layer.borderWidth = 1
        self.submittedFormView.layer.borderWidth = 1
      
        self.savedFormView.layer.borderColor = UIColor(red: 0/255, green: 81/255, blue: 132/255, alpha: 1).cgColor
        self.submittedFormView.layer.borderColor =  UIColor(red: 0/255, green: 81/255, blue: 132/255, alpha: 1).cgColor
}
    
    @IBAction func onClickFormsForReview(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "ManagerReviewFormVC") as! ManagerReviewFormVC
        vc.comingFrom = "ManagerReview"
        self.navigationController?.pushViewController(vc, animated: true)
}
        
    @IBAction func onClickSubmittedForm(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "ManagerReviewFormVC") as! ManagerReviewFormVC
        vc.comingFrom = "ManagerSubmit"
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
//      showLoading()
    }
        
        let alert = UIAlertController(title: "Health Staffing", message: "Are you sure you want to LogOut?", preferredStyle: UIAlertController.Style.alert)
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
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "MainVC") as! MainVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
//  ManagerDashboardApi
    private func managerDashboardRequestToServer(request: ManagerDashboardRequest){
        DispatchQueue.main.async {
            showLoading()
        }
        
        
        let managerDashboardResource = ManagerDashboardResource()
        managerDashboardResource.managerDashboard(request: request) { (response) in
            if response.success == "true"{
                hideLoading()
                 self.managerDashBoardData = response.data
//                let saveCount = response.data?.saveCount
//                let submitCount = response.data?.submitCount
                
                print(response)
                DispatchQueue.main.async {
                    let reviewCount =   self.managerDashBoardData?.reviewCount
                    let submitCount = self.managerDashBoardData?.submitCount
                    
                    self.reviewLbl.text = "Forms For Review - " + (reviewCount ?? "")
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
