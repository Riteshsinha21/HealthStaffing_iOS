//
//  ForgotPasswordVC.swift
//  HealthStaffing
//
//  Created by Chawtech on 29/02/24.
//

import UIKit

@available(iOS 15.0, *)
class ForgotPasswordVC: UIViewController {
    
    @IBOutlet weak var emailTxt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
   
    @IBAction func onClickContinue(_ sender: Any) {
        let email = emailTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let resetPasswordRequest = ResetPasswordRequest(email: email)
        
        let resetPasswordValidation = ResetPasswordValidation()
        let validationResult = resetPasswordValidation.validate(request: resetPasswordRequest)
        
        if validationResult.success == true{
            sendResetRequest(request: resetPasswordRequest)
        }else{
            DispatchQueue.main.async {
                self.makeToast(validationResult.error!.localizedDescription)
            }
        }
    }
    
    
    private func sendResetRequest(request: ResetPasswordRequest){
        DispatchQueue.main.async {
            showLoading()
        }
        let profileResource = ProfileResource()
        profileResource.resetPassword(request: request) { (response) in
            if response.success == "true"{
                DispatchQueue.main.async {
                    hideLoading()
                    self.emailTxt.text = ""
                    self.makeToast("New Password has been sent to your registered mail")
//                    self.showOKAlertView(title: "Success", message: response.message) {
//                       self.dismiss(animated: true, completion: nil)
//                    }
                    self.switchToLoginScreen()
                }
            }else{
                DispatchQueue.main.async {
                    hideLoading()
                    self.makeToast(response.message)
                }
            }
            
        } onError: { (error) in
            DispatchQueue.main.async {
                hideLoading()
                self.makeToast(error.localizedDescription)
            }
        }
    }
    
    func switchToLoginScreen(){
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
        
    @IBAction func onClickBackBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
