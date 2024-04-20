//
//  LoginVC.swift
//  HealthStaffing
//
//  Created by Chawtech on 29/02/24.
//

import UIKit

@available(iOS 15.0, *)
class LoginVC: UIViewController {
    
    @IBOutlet weak var employeeBtn: UIButton!
    @IBOutlet weak var managerBtn: UIButton!
    @IBOutlet weak var FirstStackView: UIStackView!
    @IBOutlet weak var userNameTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var loginView: UIView!
    
    var loginType = "Employee"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        employeeBtn.isSelected = true
        updateButtonAppearance()
        self.employeeBtn.layer.cornerRadius = 20
        self.managerBtn.layer.cornerRadius = 20
        self.FirstStackView.layer.cornerRadius = 20
        self.FirstStackView.layer.borderWidth = 0.5
        self.FirstStackView.layer.borderColor = UIColor.gray.cgColor
        passwordTxt.isSecureTextEntry = true
        
        
        setGradientBackground()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.loginView.roundCornersRadius(corners: .allCorners, radius: 20)
        self.loginView.setGradientBackground(view: loginView)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        userNameTxt.text = ""
        passwordTxt.text = ""
        userNameTxt.resignFirstResponder()
        passwordTxt.resignFirstResponder()
    }
    func setGradientBackground() {
        let colorTop =  UIColor(red: 4.0/255.0, green: 130/255.0, blue: 214.0/255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 0.0/255.0, green: 76/255.0, blue: 126.0/255.0, alpha: 1.0).cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.loginView.bounds
        self.loginView.clipsToBounds = true
        self.loginView.layer.insertSublayer(gradientLayer, at:0)
    }
    
    func switchToHomeScreen(){
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "DashBoardVC") as! DashBoardVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func switchToManagerScreen(){
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "ManagerDashBoardVC") as! ManagerDashBoardVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func onClickBackButton(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "MainVC") as! MainVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func onClickForgotPassword(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "ForgotPasswordVC") as! ForgotPasswordVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func onClickEmployee(_ sender: Any) {
        self.loginType = "Employee"
        employeeBtn.isSelected = true
        managerBtn.isSelected = false
//        employeeBtn.tintColor = UIColor.white
        employeeBtn.setTitleColor(UIColor.white, for: .normal)
//        managerBtn.tintColor = UIColor(red: 0/255, green: 81/255, blue: 132/255, alpha: 1)
        managerBtn.setTitleColor(UIColor(red: 0/255, green: 81/255, blue: 132/255, alpha: 1), for: .normal)
        updateButtonAppearance()
    }
    
    @IBAction func onClickManager(_ sender: Any) {
        self.userNameTxt.text = ""
        self.passwordTxt.text = ""
        self.loginType = "Manager"
        employeeBtn.isSelected = false
        managerBtn.isSelected = true
//        employeeBtn.tintColor = UIColor(red: 0/255, green: 81/255, blue: 132/255, alpha: 1)
        employeeBtn.setTitleColor(UIColor(red: 0/255, green: 81/255, blue: 132/255, alpha: 1), for: .normal)
        managerBtn.setTitleColor(UIColor.white, for: .normal)
//        managerBtn.tintColor = UIColor.white
        updateButtonAppearance()
    }
    
    @IBAction func onClickCoachEyeToggleBtn(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        passwordTxt.isSecureTextEntry = !sender.isSelected
    }
    
    
    @IBAction func onClickLogin(_ sender: Any) {
        hideKeyboard()
        let email = userNameTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let passsword = passwordTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let loginRequest = LoginParams(login: userNameTxt.text!.trimmingCharacters(in: .whitespacesAndNewlines), password: passwordTxt.text!.trimmingCharacters(in: .whitespacesAndNewlines))
        
        
        let loginValidation =  LoginValidation()
        let validationResult = loginValidation.validate(request: loginRequest)
        
        
        if validationResult.success{
            
            if self.loginType == "Employee"{
                employeeLoginRequestToServer(request: loginRequest)
            }
            else{
                managerLoginRequestToServer(request: loginRequest)
                
            }
            
            //            sendLoginRequestToServer(request: loginRequest, urlString: self.loginType == "Employee" ? Urls.LoginUrl : Urls.ManagerLoginUrl)
        }else{
            DispatchQueue.main.async {
                self.makeToast(validationResult.error!.localizedDescription)
            }
        }
    }
    
    
    
    //    private func sendLoginRequestToServer(request: LoginParams, urlString: String){
    //        DispatchQueue.main.async {
    //        showLoading()
    //    }
    //
    //        let loginResource = LoginResource()
    //        loginResource.login(request: request, urlString: urlString) { (response) in
    //            if response.success == "true" {
    //                DispatchQueue.main.async {
    //                    hideLoading()
    ////                    if response.data?.userRole == "emplyoee"{
    //                    if self.loginType == "Employee"{
    ////                        self.switchToHomeScreen()
    //                        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    //                        let vc = storyBoard.instantiateViewController(withIdentifier: "DashBoardVC") as! DashBoardVC
    //                        vc.welcomeUser = response.data?.name ?? ""
    //                        UserDefaults.standard.saveEmployeeType(EmpType: self.loginType)
    //                        UserDefaults.standard.setUserLoggedIn(true)
    //                        UserDefaults.standard.saveUserID(userID: "\((response.data?.userID)!)")
    ////                        UserDefaults.standard.saveEmployeeUserRole(EmpRole:"\((response.data?.userRole)!)")
    //                        UserDefaults.standard.saveEmail(email: (response.data?.email)!)
    //                        UserDefaults.standard.saveUserName(userName: (response.data?.name)!)
    //                        UserDefaults.standard.setSaveCount(saveCount: response.data?.save_count ?? "")
    //                        UserDefaults.standard.setSubmitCount(submitCount: response.data?.submit_count ?? "")
    //
    //                        let userDefaultname = UserDefaults.standard.getUserName()
    //                        let userDefaultemail = UserDefaults.standard.getEmail()
    //                        let userDefaultUserId = UserDefaults.standard.getUserID()
    //                        self.navigationController?.pushViewController(vc, animated: true)
    //                    }
    //                    else{
    //                        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    //                        let vc = storyBoard.instantiateViewController(withIdentifier: "ManagerDashBoardVC") as! ManagerDashBoardVC
    //                        vc.welcomeUser = response.data?.name ?? ""
    //                        UserDefaults.standard.saveEmployeeType(EmpType: self.loginType)
    //                        UserDefaults.standard.setUserLoggedIn(true)
    //                        UserDefaults.standard.saveUserID(userID: "\((response.data?.userID)!)")
    //                        UserDefaults.standard.saveEmail(email: (response.data?.email)!)
    //                        UserDefaults.standard.saveUserName(userName: (response.data?.name)!)
    ////                        UserDefaults.standard.saveManagerUserRole(managerRole: "\((response.data?.userRole)!)")
    //                        self.navigationController?.pushViewController(vc, animated: true)
    ////                        self.switchToManagerScreen()
    //                    }
    //
    //                    //               self.switchToHomeScreen()
    //                }
    //            }else{
    //                DispatchQueue.main.async {
    //                    hideLoading()
    //                    self.makeToast(response.message!)
    //                }
    //            }
    //
    //        } onError: { (error) in
    //            DispatchQueue.main.async {
    //                hideLoading()
    //                self.makeToast(error.localizedDescription)
    //            } }
    //    }
    
    
    
    //  Employee Login Api
    
    private func employeeLoginRequestToServer(request: LoginParams){
        DispatchQueue.main.async {
            showLoading()
        }
        let loginResource = LoginResource()
        loginResource.employeeLogin(request: request) { (response) in
            if response.success == "true"{
                DispatchQueue.main.async {
                    hideLoading()
                    //                        self.switchToHomeScreen()
                    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyBoard.instantiateViewController(withIdentifier: "DashBoardVC") as! DashBoardVC
                    vc.welcomeUser = response.data?.name ?? ""
                    UserDefaults.standard.saveEmployeeType(EmpType: self.loginType)
                    UserDefaults.standard.setUserLoggedIn(true)
                    UserDefaults.standard.saveUserID(userID: "\((response.data?.userID)!)")
                    //                        UserDefaults.standard.saveEmployeeUserRole(EmpRole:"\((response.data?.userRole)!)")
                    UserDefaults.standard.saveEmail(email: (response.data?.email)!)
                    UserDefaults.standard.saveUserName(userName: (response.data?.name)!)
                    UserDefaults.standard.setSaveCount(saveCount: response.data?.save_count ?? "")
                    UserDefaults.standard.setSubmitCount(submitCount: response.data?.submit_count ?? "")
                    UserDefaults.standard.saveUserRole(userRole: response.data?.userRole ?? "")
                    let userDefaultname = UserDefaults.standard.getUserName()
                    let userDefaultemail = UserDefaults.standard.getEmail()
                    let userDefaultUserId = UserDefaults.standard.getUserID()
                    self.navigationController?.pushViewController(vc, animated: true)
                    
                    
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
    
    
    
    
    //    ManagerLoginApi
    
    
    private func managerLoginRequestToServer(request: LoginParams){
        DispatchQueue.main.async {
            showLoading()
        }
        
        let LoginResource = LoginResource()
        LoginResource.managerLogin(request: request) { (response) in
            if response.success == "true"{
                hideLoading()
                print(response)
                DispatchQueue.main.async {
                    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyBoard.instantiateViewController(withIdentifier: "ManagerDashBoardVC") as! ManagerDashBoardVC
                    vc.welcomeUser = response.data.name ?? ""
                    UserDefaults.standard.saveEmployeeType(EmpType: self.loginType)
                    UserDefaults.standard.setUserLoggedIn(true)
                    UserDefaults.standard.saveUserID(userID: "\((response.data.managerID)!)")
                    UserDefaults.standard.saveEmail(email: (response.data.email)!)
                    UserDefaults.standard.saveUserName(userName: (response.data.name)!)
                    UserDefaults.standard.saveUserRole(userRole: response.data.userRole ?? "")
                    //                        UserDefaults.standard.saveManagerUserRole(managerRole: "\((response.data?.userRole)!)")
                    self.navigationController?.pushViewController(vc, animated: true)
                    //                        self.switchToManagerScreen()
                    
                    
                    
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
    
    
    func updateButtonAppearance() {
        let selectedColor = UIColor(red: 0/255, green: 81/255, blue: 132/255, alpha: 1)
        let deselectedColor = UIColor.white
//        let managerdeselectedColor = UIColor.white
        
        
        employeeBtn.backgroundColor = employeeBtn.isSelected ? selectedColor : deselectedColor
        managerBtn.backgroundColor = managerBtn.isSelected ? selectedColor : deselectedColor
    }
}
