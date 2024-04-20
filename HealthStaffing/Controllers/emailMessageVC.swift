//
//  emailMessageVC.swift
//  HealthStaffing
//
//  Created by Chawtech on 29/02/24.
//

import UIKit
@available(iOS 15.0, *)
class emailMessageVC: UIViewController {

    
    @IBOutlet weak var okView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.okView.roundCornersRadius(corners: .allCorners, radius: 20)
        self.okView.setGradientBackground(view: okView)
    }

    @IBAction func onClickOKBTn(_ sender: Any) {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        self.navigationController?.pushViewController(vc, animated: true)
        
     }
    
}
