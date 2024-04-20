//
//  GlobalMethos.swift
//  HealthStaffing
//
//  Created by CTS on 31/01/24.
//

import Foundation
import UIKit
import SVProgressHUD

func showLoading(){
    SVProgressHUD.show()
    SVProgressHUD.setDefaultMaskType(.none)
    SVProgressHUD.setDefaultStyle(.dark)
    SVProgressHUD.setBackgroundColor(.clear)
//    SVProgressHUD.setForegroundColor(Colors.appThemeColor)
}

func showLoadingWithBackground(){
    SVProgressHUD.show()
    SVProgressHUD.setDefaultStyle(.dark)
    SVProgressHUD.setBackgroundColor(.clear)
    SVProgressHUD.setDefaultMaskType(.black)
//    SVProgressHUD.setForegroundColor(Colors.appThemeColor)
}

func hideLoading(){
    SVProgressHUD.dismiss()
}
