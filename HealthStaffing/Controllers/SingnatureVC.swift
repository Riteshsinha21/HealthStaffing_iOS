//
//  SingnatureVC.swift
//  HealthStaffing
//
//  Created by Chawtech on 22/02/24.
//

import UIKit
class SingnatureVC: UIViewController {

    @IBOutlet weak var clearBtn: UIButton!
    
    @IBOutlet weak var submitBtn: UIButton!
    
    @IBOutlet weak var singatureView: SignatureView!
    
    var signatureData : ((UIImage) -> Void)?
    var timeSheetId = ""
    var employeeId =  ""
    
    var pickedImageUrl:URL?
    var orderedDict = OrderedDictionary<String, Any>()
    var comingFrom = " "
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clearBtn.layer.cornerRadius = 20
        submitBtn.layer.cornerRadius = 20
//        signatureData = { [weak self] (value) in
//            print(value)
//            if let pickedImage = value as? UIImage {
//                saveImageDocumentDirectory(usedImage: pickedImage)
//            }
//
//            if let imgUrl = getImageUrl()
//            {
//            self?.pickedImageUrl = imgUrl
//
//            }
////          self?.SignatureImageView.image = value
//        }
        print(pickedImageUrl)
     }
    
    @IBAction func submitActionBtn(_ sender: UIButton) {
        if self.comingFrom == "EarlyForm" {
            if let signatureImage = singatureView.getImage() {
                signatureData?(signatureImage)
                self.dismiss(animated: true)
               
            }
        } else {
            if comingFrom == "ManagerReviewFormVC"{
            managerSubmitFormData()
                
            }else{
             submitFormData()
            }
        }
        
//        if let signatureImage = singatureView.getImage() {
//            signatureData?(signatureImage)
//            self.dismiss(animated: true)
//            if comingFrom == "ManagerReviewFormVC"{
//            managerSubmitFormData()
//
//            }else{
//             submitFormData()
//            }
//
//
//        }
    }
    
    func submitFormData(){
        let userId = UserDefaults.standard.getUserID()
        let timeSheetId = timeSheetId
        print(timeSheetId)
        
        if let imgUrl = getImageUrl(){
            self.pickedImageUrl = imgUrl
        }
        
        if  pickedImageUrl == nil{
        makeToast("Please Upload Signature")
        }else{
            let params : [String:Any] = ["user_id":userId!,
                                         "timesheet_id":timeSheetId,
                                         "signature":pickedImageUrl!.lastPathComponent
            ]
            
            orderedDict.insert(key: "user_id", value: userId!)
            orderedDict.insert(key: "timesheet_id", value: timeSheetId)
            orderedDict.insert(key: "signature", value: pickedImageUrl!.lastPathComponent)
            self.requestNativeImageUpload(param: orderedDict)
//           self.requestNativeImageUpload(param: params)
        }
    }
    
    
// ManagerSubmitFormData
    
    func managerSubmitFormData(){
        let managerId = UserDefaults.standard.getUserID()
        let employeeId = employeeId
        let timeSheetId = timeSheetId
        print(timeSheetId)
        
        if  pickedImageUrl == nil{
        makeToast("Please Upload Signature")
        }else{
            let params : [String:Any] = ["manager_id":managerId!,
                                         "employee_id" : employeeId,
                                         "timesheet_id":timeSheetId,
                                         "signature":pickedImageUrl!.lastPathComponent
            ]
            
            orderedDict.insert(key: "manager_id", value: managerId!)
            orderedDict.insert(key: "employee_id", value: employeeId)
            orderedDict.insert(key: "timesheet_id", value: timeSheetId)
            orderedDict.insert(key: "signature", value: pickedImageUrl!.lastPathComponent)
            self.managerRequestNativeImageUpload(param: orderedDict)
//           self.requestNativeImageUpload(param: params)
        }
    }
    
    
    func requestNativeImageUpload(param:OrderedDictionary<String, Any>){
       showLoading()
        let fullUrl = Urls.SubmitTimeSheet
        ServerClass.sharedInstance.sendFacilityFormSignatureMultipartRequestToServerInOrderedWay(urlString: fullUrl, fileName: "signature",  sendJson: param, imageUrl: pickedImageUrl,  successBlock: { (json) in
            print(json)
            let success = json["status"].stringValue
            if success  == "success" {
                let data = json["data"].dictionaryValue
                let submitCount = data["submit_count"]?.stringValue
                let saveCount = data["save_count"]?.stringValue
                
                UserDefaults.standard.setSubmitCount(submitCount: submitCount ?? "")
                UserDefaults.standard.setSaveCount(saveCount: saveCount ?? "")
            
                print(submitCount)
                print(saveCount)
                     
                DispatchQueue.main.async {
                    hideLoading()
            }
                
                self.makeToast(json["message"].stringValue)
                self.navigateToNextScreen()
//                if let data = json["data"] as? [String: Any]{
//                let submitCount = data["submit_count"] as? String
//                let saveCount = data["save_count"] as? String
//                print(submitCount)
//                print(saveCount)
//                }
                
            }else{
               hideLoading()
                self.makeToast(json["message"].stringValue)
            }
            
        }, errorBlock: { (NSError) in
          hideLoading()
            
        })
        //         self.hideLoader()
    }
    
//  managerApi
    func managerRequestNativeImageUpload(param:OrderedDictionary<String, Any>){
       showLoading()
        let fullUrl = Urls.managerSubmitTimeSheet
        ServerClass.sharedInstance.sendFacilityFormSignatureMultipartRequestToServerInOrderedWay(urlString: fullUrl, fileName: "signature",  sendJson: param, imageUrl: pickedImageUrl,  successBlock: { (json) in
            print(json)
            let success = json["status"].stringValue
            if success  == "success" {
                let data = json["data"].dictionaryValue
                let submitCount = data["submit_count"]?.stringValue
                let reviewCount = data["review_count"]?.stringValue
                
                UserDefaults.standard.setSubmitCount(submitCount: submitCount ?? "")
//                UserDefaults.standard.setSaveCount(saveCount: saveCount ?? "")
            
                print(submitCount)
                print(reviewCount)
                     
                DispatchQueue.main.async {
                    hideLoading()
            }
                
                self.makeToast(json["message"].stringValue)
                self.navigateToNextScreen()
//                if let data = json["data"] as? [String: Any]{
//                let submitCount = data["submit_count"] as? String
//                let saveCount = data["save_count"] as? String
//                print(submitCount)
//                print(saveCount)
//                }
                
            }else{
               hideLoading()
                self.makeToast(json["message"].stringValue)
            }
            
        }, errorBlock: { (NSError) in
          hideLoading()
            
        })
        //         self.hideLoader()
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    func navigateToNextScreen(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
                self.navigationController!.popToViewController(viewControllers[viewControllers.count - 4], animated: true)
        }
        
    }
    @IBAction func onClickBackBtn(_ sender: Any) {
        //       self.dismiss(animated: true)
        if self.comingFrom == "EarlyForm" {
            self.dismiss(animated: true)
        } else {
            self.navigationController?.popViewController(animated: true)
        }
        
    }
        
    @IBAction func clearActionBtn(_ sender: UIButton) {
        singatureView.clear()
    }
    
}
