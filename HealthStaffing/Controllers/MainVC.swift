//
//  MainVC.swift
//  HealthStaffing
//
//  Created by CTS on 01/02/24.
//

import UIKit

@available(iOS 15.0, *)
class MainVC: UIViewController {
    
    @IBOutlet weak var loginImageView: UIImageView!
    @IBOutlet weak var loginLbl: UILabel!
    @IBOutlet weak var loginBackView: UIView!
    @IBOutlet weak var loginBackViewWidthConstant: NSLayoutConstraint!
    
    @IBOutlet weak var loginBtn: UIButton!
    
    @IBOutlet weak var nurseBackView: UIView!
    @IBOutlet weak var staffBackView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let loginBtn = loginBtn{
            // Center the title and image horizontally and vertically
            loginBtn.contentHorizontalAlignment = .center
            loginBtn.contentVerticalAlignment = .center
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let loginType  = UserDefaults.standard.getEmployeeType()
        if loginType == "Employee"{
            
            if let loginBtn = loginBtn{
                loginBtn.layer.cornerRadius = 20
                loginImageView.image = UIImage(named: "DASH")
                loginLbl.text = "DashBoard"
//                loginBtn.setImage(UIImage(named: "DASH"), for: .normal)
//                loginBtn.setTitle("DashBoard", for: .normal)
            }
//            if let loginBackView = loginBackView {
//                if deviceType == "iPad"
//                {
//                    self.loginBackViewWidthConstant.constant = 250
//                }else {
//                    self.loginBackViewWidthConstant.constant = 180
//                }
//                loginBackView.roundCornersRadius(corners: [.topLeft, .bottomLeft], radius: 10)
//            }
        }else if loginType == "Manager"{
            if let loginBtn = loginBtn{
                loginBtn.layer.cornerRadius = 20
//                loginBtn.setImage(UIImage(named: "DASH"), for: .normal)
//                loginBtn.setTitle("DashBoard", for: .normal)
                loginImageView.image = UIImage(named: "DASH")
                loginLbl.text = "DashBoard"
            }
//            if let loginBackView = loginBackView {
//                if deviceType == "iPad"
//                {
//                    self.loginBackViewWidthConstant.constant = 250
//                }else {
//                    self.loginBackViewWidthConstant.constant = 180
//                }
//                loginBackView.roundCornersRadius(corners: [.topLeft, .bottomLeft], radius: 10)
//            }
        }else {
            if let loginBtn = loginBtn{
                loginBtn.layer.cornerRadius = 20
//                loginBtn.setImage(UIImage(named: "Lock"), for: .normal)
//                loginBtn.setTitle("Login", for: .normal)
                loginImageView.image = UIImage(named: "Lock")
                loginLbl.text = "Login"
            }
//            if let loginBackView = loginBackView {
//                if deviceType == "iPad"
//                {
//                    self.loginBackViewWidthConstant.constant = 250
//                }else {
//                    self.loginBackViewWidthConstant.constant = 150
//                }
//                loginBackView.roundCornersRadius(corners: [.topLeft, .bottomLeft], radius: 10)
//            }
        }
    }
    
    override func viewWillLayoutSubviews() {
        if let loginBackView = loginBackView {
            loginBackView.roundCornersRadius(corners: [.topLeft, .bottomLeft], radius: 10)
        }
    }
    
        
    @IBAction func onClickNurseEmpBtn(_ sender: Any) {0
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "FacilityVC") as! FacilityVC
        self.navigationController?.pushViewController(vc, animated: true)
    }

    @IBAction func onClickFacilityBtn(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "NurseEmployersVC") as! NurseEmployersVC
        self.navigationController?.pushViewController(vc, animated: true)
//        self.printPDF()
    }
    
    @IBAction func onClickLogin(_ sender: Any) {
        let loginType  = UserDefaults.standard.getEmployeeType()
        if loginType == "Employee"{
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "DashBoardVC") as! DashBoardVC
            self.navigationController?.pushViewController(vc, animated: true)
        }else if loginType == "Manager"{
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "ManagerDashBoardVC") as! ManagerDashBoardVC
            self.navigationController?.pushViewController(vc, animated: true)
        }else {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
    func printPDF() {
            guard let path = Bundle.main.path(forResource: "465_APPLIED_MATHEMATICS", ofType: "pdf") else {
                print("PDF file not found")
                return
            }
            let pdfURL = URL(fileURLWithPath: path)
            let printController = UIPrintInteractionController.shared
            let printInfo = UIPrintInfo(dictionary:nil)
            printInfo.outputType = .general
            printInfo.jobName = "Print PDF"
            printController.printInfo = printInfo
            printController.showsNumberOfCopies = false
            printController.printingItem = pdfURL
            printController.present(animated: true, completionHandler: nil)
        }
}
   

