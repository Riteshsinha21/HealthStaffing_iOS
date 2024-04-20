//
//  SubmittedTimesheetVC.swift
//  HealthStaffing
//
//  Created by Chawtech on 18/03/24.
//

import UIKit

protocol OpenNewFormVcDelegate {
    func openNewFormVC(setValue:String)
}


class SubmittedTimesheetVC: UIViewController {
    var pushNewFormVCDelagate : OpenNewFormVcDelegate?
    
    
    
    @IBOutlet weak var popView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.popView.layer.cornerRadius = 20
    }
    
    
    @IBAction func onClickOkBtn(_ sender: Any) {
        self.dismiss(animated: true) {
            self.pushNewFormVCDelagate?.openNewFormVC(setValue: "true")
        }
//        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
//            self.navigationController!.popToViewController(viewControllers[viewControllers.count - 3], animated: true)
    }
}
