//
//  FacilityVC.swift
//  HealthStaffing
//
//  Created by CTS on 01/02/24.
//

import UIKit
import MobileCoreServices
import MBProgressHUD
import CountryPickerView
import UniformTypeIdentifiers
import SwiftyJSON
import Alamofire

@available(iOS 15.0, *)
class FacilityVC: UIViewController, UIDocumentInteractionControllerDelegate , UIDocumentPickerDelegate , UITextFieldDelegate{
    
    let datePicker = UIDatePicker()
    let datePickerr = UIDatePicker()
    
    var selectedOptions: [String] = []
    var mobileNumber:String = ""
    var pickedImageUrl:URL?
    var SignatureImageUrl:URL?
    let apiCallServices = HttpUtility.shared
    var pushVCDelagate : OpenAbotherVcDelegate?
    var countryCodePicker :CountryPickerView?
    var orderedDict = OrderedDictionary<String, Any>()

    @IBOutlet weak var stateTxt: UITextField!
    
    @IBOutlet weak var maritalStatusTxt: UITextField!
    
    @IBOutlet weak var educationTxt: UITextField!
    
    @IBOutlet weak var employementTypeTxt: UITextField!
    
    @IBOutlet weak var workOverTimeTxt: UITextField!
    
    @IBOutlet weak var dateOfBirthTxt: UITextField!
    
    @IBOutlet weak var startWorkTxt: UITextField!
    
    @IBOutlet weak var daysAvblToWorkTxt: UITextField!
    
    @IBOutlet weak var countryCodeLbl: UILabel!
    
    @IBOutlet weak var jobApplyTxt: UITextField!
    
    @IBOutlet weak var FirstNameTxt: UITextField!
    
    @IBOutlet weak var middleNmaeTxt: UITextField!
    
    @IBOutlet weak var lastNameTxt: UITextField!
    
    @IBOutlet weak var socialSecurityNoTxt: UITextField!
    
    @IBOutlet weak var addressTxt: UITextField!
    
    @IBOutlet weak var cityTxt: UITextField!
    
    @IBOutlet weak var zipCodeTxt: UITextField!
    
    @IBOutlet weak var phoneNoTxt: UITextField!
    
    @IBOutlet weak var emailTxt: UITextField!
    
    @IBOutlet weak var noOfHoursTxt: UITextField!
    
    @IBOutlet weak var skillsTxt: UITextField!
    
    @IBOutlet weak var desiredTxt: UITextField!
    
    @IBOutlet weak var attachResumeTxt: UITextField!
    
    @IBOutlet weak var SignatureImageView: UIImageView!
    
      override func viewDidLoad() {
        super.viewDidLoad()
        print(SignatureImageUrl)
        configCountryCodePicker()
        
        self.datePicker.maximumDate = Date()
        self.datePickerr.minimumDate = Date()
        
        datePicker.datePickerMode = .date
        datePickerr.datePickerMode = .date
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        } else {
            
        }
        
        if #available(iOS 13.4, *) {
            datePickerr.preferredDatePickerStyle = .wheels
        } else {
            
        }
        
        datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
        datePickerr.addTarget(self, action: #selector(dateChangedd), for: .valueChanged)
        dateOfBirthTxt.inputView = datePicker
        startWorkTxt.inputView = datePickerr
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
//        dateOfBirthTxt.text = dateFormatter.string(from: datePicker.date)
//        startWorkTxt.text = dateFormatter.string(from: datePicker.date)
    }
    
    @objc func dateChanged() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        
    dateOfBirthTxt.text = dateFormatter.string(from: datePicker.date)
//  startWorkTxt.text = dateFormatter.string(from: datePicker.date)
    }
    
    @objc func dateChangedd() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        startWorkTxt.text = dateFormatter.string(from: datePickerr.date)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        dateOfBirthTxt.resignFirstResponder()
        startWorkTxt.resignFirstResponder()
        return true
    }
    
    @IBAction func onClickBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onClickStateBtn(_ sender: Any) {
        let cancel: UIAlertAction
        
        let actionSheet = UIAlertController(title: "Choose an option", message: nil, preferredStyle: .actionSheet)
        
        let option1 = UIAlertAction(title: "Alabama", style: .default) { (action) in
            self.stateTxt.text = "Alabama"
        }
        
        let option2 = UIAlertAction(title: "Alaska", style: .default) { (action) in
            self.stateTxt.text = "Alaska"
            print("Option 2 selected")
        }
        
        let option3 = UIAlertAction(title: "Arizona", style: .default) { (action) in
            self.stateTxt.text = "Arizona"
            print("Option 2 selected")
        }
        
        let option4 = UIAlertAction(title: "California", style: .default) { (action) in
            self.stateTxt.text = "California"
            print("Option 2 selected")
        }
        
        let option5 = UIAlertAction(title: "Colorado", style: .default) { (action) in
            self.stateTxt.text = "Colorado"
            print("Option 2 selected")
        }
        
        let option6 = UIAlertAction(title: "Connecticut", style: .default) { (action) in
            self.stateTxt.text = "Connecticut"
            print("Option 2 selected")
        }
        
        let option7 = UIAlertAction(title: "Delaware", style: .default) { (action) in
            self.stateTxt.text = "Delaware"
            print("Option 2 selected")
        }
        let option8 = UIAlertAction(title: "District of columbia", style: .default) { (action) in
            self.stateTxt.text = "District of columbia"
            print("Option 2 selected")
        }
        let option9 = UIAlertAction(title: "Florida", style: .default) { (action) in
            self.stateTxt.text = "Florida"
            print("Option 2 selected")
        }
        let option10 = UIAlertAction(title: "Georgia", style: .default) { (action) in
            self.stateTxt.text = "Georgia"
            print("Option 2 selected")
        }
        let option11 = UIAlertAction(title: "Hawali", style: .default) { (action) in
            self.stateTxt.text = "Hawali"
            print("Option 2 selected")
        }
        let option12 = UIAlertAction(title: "Idaho", style: .default) { (action) in
            self.stateTxt.text = "Idaho"
            print("Option 2 selected")
        }
        let option13 = UIAlertAction(title: "Illinois", style: .default) { (action) in
            self.stateTxt.text = "Illinois"
            print("Option 2 selected")
        }
        let option14 = UIAlertAction(title: "Indiana", style: .default) { (action) in
            self.stateTxt.text = "Indiana"
            print("Option 2 selected")
        }
        let option15 = UIAlertAction(title: "Lowa", style: .default) { (action) in
            self.stateTxt.text = "Lowa"
            print("Option 2 selected")
        }
        let option16 = UIAlertAction(title: "Kansas", style: .default) { (action) in
            self.stateTxt.text = "Kansas"
            print("Option 2 selected")
        }
        let option17 = UIAlertAction(title: "Kentucky", style: .default) { (action) in
            self.stateTxt.text = "Kentucky"
            print("Option 2 selected")
        }
        let option18 = UIAlertAction(title: "Louisiana", style: .default) { (action) in
            self.stateTxt.text = "Louisiana"
            print("Option 2 selected")
        }
        let option19 = UIAlertAction(title: "Maine", style: .default) { (action) in
            self.stateTxt.text = "Maine"
            print("Option 2 selected")
        }
        let option20 = UIAlertAction(title: "Maryland", style: .default) { (action) in
            self.stateTxt.text = "Maryland"
            print("Option 2 selected")
        }
        let option21 = UIAlertAction(title: "Massachusetts", style: .default) { (action) in
            self.stateTxt.text = "Massachusetts"
            print("Option 2 selected")
        }
        let option22 = UIAlertAction(title: "Michigan", style: .default) { (action) in
            self.stateTxt.text = "Michigan"
            print("Option 2 selected")
        }
        let option23 = UIAlertAction(title: "Minnesota", style: .default) { (action) in
            self.stateTxt.text = "Minnesota"
            print("Option 2 selected")
        }
        let option24 = UIAlertAction(title: "Mississippi", style: .default) { (action) in
            self.stateTxt.text = "Mississippi"
            print("Option 2 selected")
        }
        let option25 = UIAlertAction(title: "Missouri", style: .default) { (action) in
            self.stateTxt.text = "Missouri"
            print("Option 2 selected")
        }
        let option26 = UIAlertAction(title: "Montana", style: .default) { (action) in
            self.stateTxt.text = "Montana"
            print("Option 2 selected")
        }
        let option27 = UIAlertAction(title: "Nebraska", style: .default) { (action) in
            self.stateTxt.text = "Nebraska"
            print("Option 2 selected")
        }
        let option28 = UIAlertAction(title: "Nevada", style: .default) { (action) in
            self.stateTxt.text = "Nevada"
            print("Option 2 selected")
        }
        let option29 = UIAlertAction(title: "New hampshire", style: .default) { (action) in
            self.stateTxt.text = "New hampshire"
            print("Option 2 selected")
        }
        let option30 = UIAlertAction(title: "New jersey", style: .default) { (action) in
            self.stateTxt.text = "New jersey"
            print("Option 2 selected")
        }
        let option31 = UIAlertAction(title: "New Mexico", style: .default) { (action) in
            self.stateTxt.text = "New Mexico"
            print("Option 2 selected")
        }
        
        let option32 = UIAlertAction(title: "New york", style: .default) { (action) in
            self.stateTxt.text = "New york"
            print("Option 2 selected")
        }
        let option33 = UIAlertAction(title: "North Dacota", style: .default) { (action) in
            self.stateTxt.text = "North Dacota"
            print("Option 2 selected")
        }
        let option34 = UIAlertAction(title: "Ohio", style: .default) { (action) in
            self.stateTxt.text = "Ohio"
            print("Option 2 selected")
        }
        let option35 = UIAlertAction(title: "Oklahoma", style: .default) { (action) in
            self.stateTxt.text = "Oklahoma"
            print("Option 2 selected")
        }
        
        let option36 = UIAlertAction(title: "Oregon", style: .default) { (action) in self.stateTxt.text = "Oregon"
            print("Option 2 selected")
        }
        
        let option37 = UIAlertAction(title: "Pennsylvania", style: .default) { (action) in
            self.stateTxt.text = "Pennsylvania"
            print("Option 2 selected")
        }
        
        let option38 = UIAlertAction(title: "Puerto rico", style: .default) { (action) in
            self.stateTxt.text = "Puerto rico"
            print("Option 2 selected")
        }
        
        let option39 = UIAlertAction(title: "Oklahoma", style: .default) { (action) in
            self.stateTxt.text = "Oklahoma"
            print("Option 2 selected")
        }
        
        let option40 = UIAlertAction(title: "Rhode island", style: .default) { (action) in
            self.stateTxt.text = "Rhode island"
            print("Option 2 selected")
        }
        
        let option41 = UIAlertAction(title: "South carolina", style: .default) { (action) in
            self.stateTxt.text = "South carolina"
            print("Option 2 selected")
        }
        
        let option42 = UIAlertAction(title: "Southdacota", style: .default) { (action) in
            self.stateTxt.text = "Southdacota"
            print("Option 2 selected")
        }
        
        let option43 = UIAlertAction(title: "Tennesse", style: .default) { (action) in
            self.stateTxt.text = "Tennesse"
            print("Option 2 selected")
        }
        
        let option44 = UIAlertAction(title: "Texas", style: .default) { (action) in
            self.stateTxt.text = "Texas"
            print("Option 2 selected")
        }
        
        let option45 = UIAlertAction(title: "Utah", style: .default) { (action) in
            self.stateTxt.text = "Utah"
            print("Option 2 selected")
        }
        
        let option46 = UIAlertAction(title: "Vermont", style: .default) { (action) in
            self.stateTxt.text = "Vermont"
            print("Option 2 selected")
        }
        let option47 = UIAlertAction(title: "Vergin island", style: .default) { (action) in
            self.stateTxt.text = "Vergin island"
            print("Option 2 selected")
        }
        
        let option48 = UIAlertAction(title: "Verginia", style: .default) { (action) in
            self.stateTxt.text = "Verginia"
            print("Option 2 selected")
        }
        let option49 = UIAlertAction(title: "Washington", style: .default) { (action) in
            self.stateTxt.text = "Washington"
            print("Option 2 selected")
        }
        let option50 = UIAlertAction(title: "West verginia", style: .default) { (action) in
            self.stateTxt.text = "West verginia"
            print("Option 2 selected")
        }
        let option51 = UIAlertAction(title: "Wisconsin", style: .default) { (action) in
            self.stateTxt.text = "Wisconsin"
            print("Option 2 selected")
        }
        let option52 = UIAlertAction(title: "Wyoming", style: .default) { (action) in
            self.stateTxt.text = "Wyoming"
            print("Option 2 selected")
        }
        
        
        // Initialize the cancel action
        cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            
            print("Cancelled")
        }
        
        actionSheet.addAction(option1)
        actionSheet.addAction(option2)
        actionSheet.addAction(option3)
        actionSheet.addAction(option4)
        actionSheet.addAction(option5)
        actionSheet.addAction(option6)
        actionSheet.addAction(option7)
        actionSheet.addAction(option8)
        actionSheet.addAction(option9)
        actionSheet.addAction(option10)
        actionSheet.addAction(option11)
        actionSheet.addAction(option12)
        actionSheet.addAction(option13)
        actionSheet.addAction(option14)
        actionSheet.addAction(option15)
        actionSheet.addAction(option16)
        actionSheet.addAction(option17)
        actionSheet.addAction(option18)
        actionSheet.addAction(option19)
        actionSheet.addAction(option20)
        actionSheet.addAction(option21)
        actionSheet.addAction(option22)
        actionSheet.addAction(option23)
        actionSheet.addAction(option24)
        
        actionSheet.addAction(option25)
        actionSheet.addAction(option26)
        actionSheet.addAction(option27)
        actionSheet.addAction(option28)
        actionSheet.addAction(option29)
        actionSheet.addAction(option30)
        actionSheet.addAction(option31)
        actionSheet.addAction(option32)
        actionSheet.addAction(option33)
        actionSheet.addAction(option34)
        actionSheet.addAction(option35)
        actionSheet.addAction(option36)
        
        actionSheet.addAction(option37)
        actionSheet.addAction(option38)
        actionSheet.addAction(option39)
        actionSheet.addAction(option40)
        actionSheet.addAction(option41)
        actionSheet.addAction(option42)
        actionSheet.addAction(option43)
        actionSheet.addAction(option44)
        actionSheet.addAction(option45)
        actionSheet.addAction(option46)
        actionSheet.addAction(option47)
        actionSheet.addAction(option48)
        actionSheet.addAction(option49)
        actionSheet.addAction(option50)
        actionSheet.addAction(option51)
        actionSheet.addAction(option52)
        
        actionSheet.addAction(cancel)
        
        if let popoverPresentationController = actionSheet.popoverPresentationController {
            popoverPresentationController.sourceView = view
            popoverPresentationController.sourceRect = CGRect(x: view.bounds.midX, y: view.bounds.midY, width: 0, height: 0)
            popoverPresentationController.permittedArrowDirections = []
        }
        
        actionSheet.popoverPresentationController?.sourceView = self.view
        actionSheet.popoverPresentationController?.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
        
        present(actionSheet, animated: true, completion: nil)
    }
    
    @IBAction func onClickCountryCode(_ sender: Any) {
        self.countryCodePicker?.showCountriesList(from: self)
    }
    
    
    @IBAction func onClickMaritalStatus(_ sender: Any) {
        let cancel: UIAlertAction
        
        let actionSheet = UIAlertController(title: "Choose an option", message: nil, preferredStyle: .actionSheet)
        
        let option1 = UIAlertAction(title: "Single", style: .default) { (action) in
            self.maritalStatusTxt.text = "Single"
            print("Option 1 selected")
        }
        
        let option2 = UIAlertAction(title: "Married", style: .default) { (action) in
            self.maritalStatusTxt.text = "Married"
            print("Option 2 selected")
        }
        
        let option3 = UIAlertAction(title: "Anualled", style: .default) { (action) in
            self.maritalStatusTxt.text = "Anualled"
            print("Option 2 selected")
        }
        
        let option4 = UIAlertAction(title: "Seperated", style: .default) { (action) in
            self.maritalStatusTxt.text = "Seperated"
            print("Option 2 selected")
        }
        
        let option5 = UIAlertAction(title: "Widowed", style: .default) { (action) in
            self.maritalStatusTxt.text = "Widowed"
            print("Option 2 selected")
        }
        
        cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            // Handle cancel selected
            print("Cancelled")
        }
        
        actionSheet.addAction(option1)
        actionSheet.addAction(option2)
        actionSheet.addAction(option3)
        actionSheet.addAction(option4)
        actionSheet.addAction(option5)
        
        actionSheet.addAction(cancel)
        
        actionSheet.popoverPresentationController?.sourceView = self.view
        actionSheet.popoverPresentationController?.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
        if let popoverPresentationController = actionSheet.popoverPresentationController {
            popoverPresentationController.sourceView = view
            popoverPresentationController.sourceRect = CGRect(x: view.bounds.midX, y: view.bounds.midY, width: 0, height: 0)
            popoverPresentationController.permittedArrowDirections = []
        }
        present(actionSheet, animated: true, completion: nil)
    }
    
    @IBAction func onClickEducation(_ sender: Any) {
        let cancel: UIAlertAction
        
        let actionSheet = UIAlertController(title: "Choose an option", message: nil, preferredStyle: .actionSheet)
        
        let option1 = UIAlertAction(title: "High School", style: .default) { (action) in
            self.educationTxt.text = "High School"
            print("Option 1 selected")
        }
        
        let option2 = UIAlertAction(title: "Vocational - technical", style: .default) { (action) in
            self.educationTxt.text = "Vocational - technical"
            print("Option 2 selected")
        }
        let option3 = UIAlertAction(title: "College", style: .default) { (action) in
            self.educationTxt.text = "College"
            print("Option 2 selected")
        }
        let option4 = UIAlertAction(title: "Post Graduate", style: .default) { (action) in
            self.educationTxt.text = "Post Graduate"
            print("Option 2 selected")
        }
        
        // Initialize the cancel action
        cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            print("Cancelled")
        }
        
        actionSheet.addAction(option1)
        actionSheet.addAction(option2)
        actionSheet.addAction(option3)
        actionSheet.addAction(option4)
        actionSheet.addAction(cancel)
        
        actionSheet.popoverPresentationController?.sourceView = self.view
        actionSheet.popoverPresentationController?.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
        
        if let popoverPresentationController = actionSheet.popoverPresentationController {
            popoverPresentationController.sourceView = view
            popoverPresentationController.sourceRect = CGRect(x: view.bounds.midX, y: view.bounds.midY, width: 0, height: 0)
            popoverPresentationController.permittedArrowDirections = []
        }
        
        present(actionSheet, animated: true, completion: nil)
    }
    
    @IBAction func onClickTypeDesiredBtn(_ sender: Any) {
        let cancel: UIAlertAction
        
        let actionSheet = UIAlertController(title: "Choose an option", message: nil, preferredStyle: .actionSheet)
        
        let option1 = UIAlertAction(title: "Full-Time", style: .default) { (action) in
            self.employementTypeTxt.text = "Full-Time"
            print("Option 1 selected")
        }
        
        let option2 = UIAlertAction(title: "Part-Time", style: .default) { (action) in  self.employementTypeTxt.text = "Part-Time"    // Handle Option 2 selected
            print("Option 2 selected")
        }
        
        // Initialize the cancel action
        cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            // Handle cancel selected
            print("Cancelled")
        }
        
        actionSheet.addAction(option1)
        actionSheet.addAction(option2)
        actionSheet.addAction(cancel)
        
        actionSheet.popoverPresentationController?.sourceView = self.view
        actionSheet.popoverPresentationController?.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
        
        if let popoverPresentationController = actionSheet.popoverPresentationController {
            popoverPresentationController.sourceView = view
            popoverPresentationController.sourceRect = CGRect(x: view.bounds.midX, y: view.bounds.midY, width: 0, height: 0)
            popoverPresentationController.permittedArrowDirections = []
        }
        
        present(actionSheet, animated: true, completion: nil)
    }
    
    
    @IBAction func onClickAvailableToWorkBtn(_ sender: Any) {
        let cancel: UIAlertAction
        
        let actionSheet = UIAlertController(title: "Choose an option", message: nil, preferredStyle: .actionSheet)
        
        let option1 = UIAlertAction(title: "Yes", style: .default) { (action) in
            self.workOverTimeTxt.text = "Yes"
            print("Option 1 selected")
        }
        
        let option2 = UIAlertAction(title: "No", style: .default) { (action) in
            self.workOverTimeTxt.text = "No"
            print("Option 2 selected")
        }
        
        // Initialize the cancel action
        cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            print("Cancelled")
        }
        
        actionSheet.addAction(option1)
        actionSheet.addAction(option2)
        actionSheet.addAction(cancel)
        
        actionSheet.popoverPresentationController?.sourceView = self.view
        actionSheet.popoverPresentationController?.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
        
        if let popoverPresentationController = actionSheet.popoverPresentationController {
            popoverPresentationController.sourceView = view
            popoverPresentationController.sourceRect = CGRect(x: view.bounds.midX, y: view.bounds.midY, width: 0, height: 0)
            popoverPresentationController.permittedArrowDirections = []
        }
        
        present(actionSheet, animated: true, completion: nil)
    }
    
    @IBAction func onClickSubmitBtn(_ sender: Any){
        hideKeyboard()
        if validateTextFields() {
            submitFormData()
        } else {
            print("Validation failed. Please check the fields.")
        }
        
    }
    
    func validateTextFields() -> Bool {
        var isValid = true
        
        if !isValidInput(textField: jobApplyTxt, errorMessage: "Enter job apply for ") {
            isValid = false
        }
        
        else if !isValidInput(textField: FirstNameTxt, errorMessage: "Enter First Name") {
            isValid = false
        }
        
        //        else  if !isValidInput(textField: middleNmaeTxt, errorMessage: "Enter Middle Name") {
        //            isValid = false
        //        }
        
        else if !isValidInput(textField: lastNameTxt, errorMessage: "Enter Last Name") {
            isValid = false
        }
        
        else  if !isValidInput(textField: socialSecurityNoTxt, errorMessage: "Enter Social Security No.") {
            isValid = false
        }
        
        else if !isValidInput(textField: addressTxt, errorMessage: "Enter Address") {
            isValid = false
        }
        
        else if !isValidInput(textField: cityTxt, errorMessage: "Enter City") {
            isValid = false
        }
        //        else if !isValidInput(textField: stateTxt, errorMessage: "Enter State") {
        //            isValid = false
        //        }
        
        else  if !isValidInput(textField: zipCodeTxt, errorMessage: "Enter Zip Code") {
            isValid = false
        }
        
        else if !isValidInput(textField: phoneNoTxt, errorMessage: "Enter Phone No.") {
            isValid = false
        }
        
        else if  phoneNoTxt.text?.isValidPhone() == false {
            isValid = false
            makeToast("Please Enter 10 Digit Phone Number")
        }
        
        
        else if !isValidInput(textField: emailTxt, errorMessage: "Enter Email") {
            isValid = false
        }
        
        else if  emailTxt.text?.isValidEmail() == false {
            isValid = false
            makeToast("Please Enter Valid Email")
        }
        
        //        else if !isValidInput(textField: maritalStatusTxt, errorMessage: "Select Marital Status") {
        //            isValid = false
        //        }
        
        else if !isValidInput(textField: educationTxt, errorMessage: "Select Education") {
            isValid = false
        }
        else if !isValidInput(textField: employementTypeTxt, errorMessage: "Select Employment Type") {
            isValid = false
        }
        
        else if !isValidInput(textField: daysAvblToWorkTxt, errorMessage: "Select Days Available To Work") {
            isValid = false
        }
        
        
        //       else  if !isValidInput(textField: PrefferedDate, errorMessage: "Enter Prefferd Date") {
        //            isValid = false
        //        }
        
        else if !isValidInput(textField: noOfHoursTxt, errorMessage: "Enter Number of Hours") {
            isValid = false
        }
        
        //       else if !isValidInput(textField: workOverTimeTxt, errorMessage: "Select Available to Work OverTime ") {
        //            isValid = false
        //        }
        
        else if !isValidInput(textField: skillsTxt, errorMessage: "Enter Skills ") {
            isValid = false
        }
        
        else if !isValidInput(textField: startWorkTxt, errorMessage: "Enter date can you start work") {
            isValid = false
        }
        
        
        else if !isValidInput(textField: desiredTxt, errorMessage: "Enter Desired Salary ") {
            isValid = false
        }
        else if !isValidInput(textField: attachResumeTxt, errorMessage: "Please Attach resume") {
            isValid = false
        }
        
        else
        {
            //                    let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            //                    let vc = storyBoard.instantiateViewController(withIdentifier: "SubmitPopupVC") as! SubmitPopupVC
            //                    vc.hidesBottomBarWhenPushed = true
            //                    vc.modalPresentationStyle = .fullScreen
            //                    vc.modalTransitionStyle = .crossDissolve
            //
            //                    self.navigationController?.present(vc, animated: true)
        }
        
        return isValid
    }
    
    func isValidInput(textField: UITextField, errorMessage: String) -> Bool {
        guard let text = textField.text, !text.isEmpty else {
            
            view.makeToast(errorMessage, duration: 2.0, position: .center)
            return false
        }
        return true
    }
        
    @IBAction func onClickAttachFile(_ sender: Any) {
        openFilePicker()
        //        let documentPicker = UIDocumentPickerViewController(documentTypes: [String(kUTTypePDF), String(kUTTypeText), String(kUTTypePlainText)], in: .import)
        //
        //        documentPicker.delegate = self
        //        documentPicker.allowsMultipleSelection = false
        //        present(documentPicker, animated: true, completion: nil)
    }
    
    func openFilePicker() {
        //            let documentPicker = UIDocumentPickerViewController(documentTypes: [String(kUTTypePDF)], in: .import)
        //            documentPicker.delegate = self
        //            present(documentPicker, animated: true, completion: nil)
        let types: [String] = ["com.apple.iwork.pages.pages", "com.apple.iwork.numbers.numbers", "com.apple.iwork.keynote.key","public.image", "com.apple.application", "public.item", "public.content", "public.audiovisual-content", "public.movie", "public.audiovisual-content", "public.video", "public.audio", "public.text", "public.data", "public.zip-archive", "com.pkware.zip-archive", "public.composite-content"]
        let documentPicker = UIDocumentPickerViewController(documentTypes: types, in: .import)
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = false
        documentPicker.modalPresentationStyle = .formSheet
        present(documentPicker, animated: true, completion: nil)
    }
    
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let myURL = urls.first else {
            return
        }
        print("import result : \(myURL)")
        
        if let selectedFileURL = urls.first {
            attachResumeTxt.text = selectedFileURL.lastPathComponent
        }
        
        let fileUrlkk = Foundation.URL(string: myURL.absoluteString)
        let filename = URL(fileURLWithPath: String(describing:urls)).lastPathComponent
        
        do {
            let data = try Data(contentsOf: fileUrlkk!)
            let imageSize: Int = data.count
            if Double(imageSize) / 1000000.0 < 25.0 {
                //                self.uploadFileAPI(data, fileNamee: myURL.lastPathComponent)
                self.pickedImageUrl = myURL
                //                self.requestNativeImageUpload(filename)
            }
        } catch {
            
        }
    }
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        if let popoverPresentationController = alert.popoverPresentationController {
            popoverPresentationController.sourceView = view
            popoverPresentationController.sourceRect = CGRect(x: view.bounds.midX, y: view.bounds.midY, width: 0, height: 0)
            popoverPresentationController.permittedArrowDirections = []
        }
        present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func onClickUploadSignature(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "SingnatureVC") as! SingnatureVC
        vc.comingFrom = "EarlyForm"
        vc.signatureData = { [weak self] (value) in
            print(value)
            if let pickedImage = value as? UIImage {
                saveImageDocumentDirectory(usedImage: pickedImage)
            }
            if let imgUrl = getImageUrl()
            {
                self?.SignatureImageUrl = imgUrl
                
            }
            self?.SignatureImageView.image = value
        }
        
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true, completion: nil)
    }
    
    
    
    
    @IBAction func onClickDaysAvlBtn(_ sender: Any) {
        let alertController = UIAlertController(title: "Select Options", message: nil, preferredStyle: .actionSheet)
        
        let options = ["Mon", "Tues","Wed", "Thurs", "Fri" , "Sat" , "Sun"]
        for option in options {
            let action = UIAlertAction(title: option, style: .default) { _ in
                if let index = self.selectedOptions.firstIndex(of: option) {
                    self.selectedOptions.remove(at: index)
                } else {
                    self.selectedOptions.append(option)
                }
                self.updateTextField()
            }
            if self.selectedOptions.contains(option) {
                action.setValue(true, forKey: "checked")
            }
            alertController.addAction(action)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        if let popoverPresentationController = alertController.popoverPresentationController {
            popoverPresentationController.sourceView = view
            popoverPresentationController.sourceRect = CGRect(x: view.bounds.midX, y: view.bounds.midY, width: 0, height: 0)
            popoverPresentationController.permittedArrowDirections = []
        }
        present(alertController, animated: true, completion: nil)
    }
    
    func updateTextField() {
        let selectedOptionsText = selectedOptions.joined(separator: ", ")
        daysAvblToWorkTxt.text = selectedOptionsText
    }
    
    // API Integration
    
    func submitFormData() {
        //        DispatchQueue.main.async {
        //            self.showLoader()
        //        }
        
        let jobApplyFor = jobApplyTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let firstName = FirstNameTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let middleName = middleNmaeTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let lastName = lastNameTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let socialSecurityNo = socialSecurityNoTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let dob = dateOfBirthTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let address = addressTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let city = cityTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let state = stateTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let zipCode = zipCodeTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let countryCode = countryCodeLbl.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let phoneNo = phoneNoTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let emailAddress = emailTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let maritalStatus = maritalStatusTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let education = educationTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let employementType = employementTypeTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let daysAvblToWork = daysAvblToWorkTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let noOfHours = noOfHoursTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let avblToWork = daysAvblToWorkTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let skills = skillsTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let dateCanYouStartWork = startWorkTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let desiredSalary = desiredTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let attachResume = attachResumeTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let uploadSignature =
        SignatureImageView.image
        
        //        let params =  FacilityRequest( jobApplyingFor: jobApplyFor, firstName: firstName, middleInitial: middleName, lastName: lastName, socialSecurityNumber: socialSecurityNo, dateOfBirth: dob, address: address, city: city, state: "up", zipcode: zipCode, phoneNumber: phoneNo, emailAddress: emailAddress, maritalStatus: maritalStatus, education: education, employmentTypeDesired: employementType, daysAvailableToWork: daysAvblToWork, numberOfHoursAvailableToWork: noOfHours, availableToWorkOvertime: avblToWork, skills: skills, dateToStartWork: dateCanYouStartWork, desiredSalary: desiredSalary, attachment: pickedImageUrl!.absoluteString )
        
        
        if  SignatureImageUrl == nil{
            makeToast("Please Upload Signature")
        }else{
            
            // Function to insert a key-value pair into the dictionary
            //           insert(key: "Job_Applying_for", value: jobApplyFor!)
            //           insert(key: "First_Name", value: firstName!)
            //           insert(key: "Middle_Initial", value: jobApplyFor!)
            //           insert(key: "Last_Name", value: lastName!)
            
            let params : [String:Any] = ["Job_Applying_for":jobApplyFor!,
                                         "First_Name":firstName!,
                                         "Middle_Initial":middleName!,
                                         "Last_Name":lastName!,
                                         "Social_Security_Number":socialSecurityNo!,
                                         "Date_of_Birth":dob!,
                                         "Address":address!,
                                         "City":city!,
                                         "State":state!,
                                         "Zipcode":zipCode!,
                                         "Country_Code":countryCode!,
                                         "Phone_Number":phoneNo!,
                                         "Email_Address":emailAddress!,
                                         "Marital_Status":maritalStatus!,
                                         "Education":education!,
                                         "Employment_Type_Desired":employementType!,
                                         "Days_Available_to_Work":daysAvblToWork!,
                                         "Number_of_Hours_Available_to_Work":noOfHours!,
                                         "Available_to_work_overtime":avblToWork!,
                                         "Skills":skills!,
                                         "Date_to_start_work":dateCanYouStartWork!,
                                         "Desired_Salary":desiredSalary!,
                                         "attachment" : pickedImageUrl!.absoluteString ,
                                         "signature":SignatureImageUrl!.absoluteString]
            print(params)
          
            orderedDict.insert(key: "Job_Applying_for", value: jobApplyFor!)
            orderedDict.insert(key: "First_Name", value: firstName!)
            orderedDict.insert(key: "Middle_Initial", value: middleName!)
            orderedDict.insert(key: "Last_Name", value: lastName!)
            orderedDict.insert(key: "Social_Security_Number", value: socialSecurityNo!)
            orderedDict.insert(key: "Date_of_Birth", value: dob!)
            orderedDict.insert(key: "Address", value: address!)
            orderedDict.insert(key: "City", value: city!)
            orderedDict.insert(key: "State", value: state!)
            orderedDict.insert(key: "Zipcode", value: zipCode!)
            orderedDict.insert(key: "Country_Code", value: countryCode!)
            orderedDict.insert(key: "Phone_Number", value: phoneNo!)
            orderedDict.insert(key: "Email_Address", value: emailAddress!)
            orderedDict.insert(key: "Marital_Status", value: maritalStatus!)
            orderedDict.insert(key: "Education", value: education!)
            orderedDict.insert(key: "Employment_Type_Desired", value: employementType!)
            orderedDict.insert(key: "Days_Available_to_Work", value: daysAvblToWork!)
            orderedDict.insert(key: "Number_of_Hours_Available_to_Work", value: noOfHours!)
            orderedDict.insert(key: "Available_to_work_overtime", value: avblToWork!)
            orderedDict.insert(key: "Skills", value: skills!)
            orderedDict.insert(key: "Date_to_start_work", value: dateCanYouStartWork!)
            orderedDict.insert(key: "Desired_Salary", value: desiredSalary!)
            orderedDict.insert(key: "attachment", value: pickedImageUrl!.lastPathComponent)
            orderedDict.insert(key: "signature", value: SignatureImageUrl!.lastPathComponent)
            print(orderedDict)
            
            self.requestNativeImageUpload(param: orderedDict)
            
        }
        
    }
 
        
    
    func requestNativeImageUpload(param:OrderedDictionary<String, Any>){
        showLoader()
        let fullUrl = Urls.facilityUrl
        
        ServerClass.sharedInstance.sendSignatureMultipartRequestToServerInOrderedWay(urlString: fullUrl, fileName: "attachment[]", signatureName: "signature",  sendJson: param, imageUrl: pickedImageUrl, signatureUrl:SignatureImageUrl, successBlock: { (json) in
            print(json)
            // self.hideLoader()
            //hideAllProgressOnView(appDelegateInstance.window!)
            let success = json["status"].stringValue
            if success  == "success" {
                DispatchQueue.main.async {
                    self.hideLoader()
                }
                self.navigateToNextScreen()
                
            }else{
                self.hideLoader()
                self.makeToast(json["message"].stringValue)
            }
            
        }, errorBlock: { (NSError) in
            self.hideLoader()
        })
        //         self.hideLoader()
        
    }

   
//    NAVIGATION
    func navigateToNextScreen(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let popupVC = storyboard.instantiateViewController(withIdentifier: "SubmitPopupVC") as? SubmitPopupVC {
            popupVC.pushVCDelagate = self
            popupVC.modalPresentationStyle = .overFullScreen
            present(popupVC, animated: true, completion: nil)

        }

    }
    
    
    
//    LOADER
    
    func showLoader() {
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.label.text = "Loading..."
    }
    
    func hideLoader() {
        MBProgressHUD.hide(for: self.view, animated: true)
    }
    
   
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
    
   
//    COUNTRYCODE
    
    func configCountryCodePicker(){
          self.countryCodePicker = CountryPickerView()
        self.countryCodePicker?.delegate = self
        self.countryCodePicker?.dataSource = self
      }
    
    }
   
@available(iOS 15.0, *)
extension FacilityVC: CountryPickerViewDelegate, CountryPickerViewDataSource{
    func countryPickerView(_ countryPickerView: CountryPickerView, didSelectCountry country: Country) {
        self.countryCodeLbl.text = country.phoneCode

    }
    
    func navigationTitle(in countryPickerView: CountryPickerView) -> String? {
        return "Select your country"
    }
    
}
@available(iOS 15.0, *)
extension FacilityVC :OpenAbotherVcDelegate {
    func openVC(setValue: String) {
        self.performNavigationToNextScreen()
    }
    
    func performNavigationToNextScreen() {
        let nextViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainVC") as! MainVC
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
}

// Latest code 27/02/2024 8:21pm
