//
//  SubmitPopupVC.swift
//  HealthStaffing
//
//  Created by CTS on 05/02/24.
//

import UIKit

protocol OpenAbotherVcDelegate {
    func openVC(setValue:String)
}

@available(iOS 15.0, *)
class SubmitPopupVC: UIViewController {
   
    @IBOutlet weak var popUpView: UIView!
    var pushVCDelagate : OpenAbotherVcDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.popUpView.layer.cornerRadius = 20
    }
    
    @IBAction func onClickOkBtn(_ sender: Any) {
        self.dismiss(animated: true) {
//            showLoading()
            self.pushVCDelagate?.openVC(setValue: "true")
        }
        
//                let storyBoard = UIStoryboard(name: "Main", bundle: nil)
//                let nextVC = storyBoard.instantiateViewController(withIdentifier: "MainVC") as! MainVC
//        if let navigationController = self.navigationController {
//            self.dismiss(animated: true)
//            navigationController.popToRootViewController(animated: true)
        }
    }

    
