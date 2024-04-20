//
//  NurseEmployersVC.swift
//  HealthStaffing
//
//  Created by CTS on 01/02/24.
//

import UIKit
import DropDown
import Toast_Swift
import SVProgressHUD
import MBProgressHUD
import CountryPickerView


@available(iOS 15.0, *)
class NurseEmployersVC: UIViewController , UITextFieldDelegate {
    
    @IBOutlet weak var contactxt: UITextField!
    
    @IBOutlet weak var bestTimeToCallTxt: UITextField!
    
    @IBOutlet weak var PrefferedDate: UITextField!
    
    @IBOutlet weak var prefferdTimeTxt: UITextField!
    
    @IBOutlet weak var fullNameTxt: UITextField!
    
    @IBOutlet weak var companyNameTxt: UITextField!
    
    @IBOutlet weak var positionInCmpnyTxt: UITextField!
    
    @IBOutlet weak var positionIntHeCompanyTxt: UITextField!
    
    @IBOutlet weak var companyAddressTxt: UITextField!
    
    @IBOutlet weak var cityTxt: UITextField!
    
    @IBOutlet weak var stateTxt: UITextField!
    
    @IBOutlet weak var zipCodeTxt: UITextField!
    
    @IBOutlet weak var phoneNumberTxt: UITextField!
    
    @IBOutlet weak var countryCodeLbl: UILabel!
    
    @IBOutlet weak var emailTxt: UITextField!
    
    @IBOutlet weak var prefferdDateTxt: UITextField!
    
    @IBOutlet weak var positionInYourCmpnyTxt: UITextField!
    
    @IBOutlet weak var additionaInfoTxt: UITextField!
    
    @IBOutlet weak var SignatureImageView: UIImageView!
    
    
    let datePicker = UIDatePicker()
    let dateFormatter = DateFormatter()
    let timePicker = UIDatePicker()
    let apiCallServices = HttpUtility.shared
    var employeeList = [EmployeeResponseData]()
    var pickedImageUrl:URL?
    
    var countryCodePicker :CountryPickerView?
    //    let phnNumberTxt = phoneNumberTxt
    //    var phoneNumberTxt: String = ""
    
    
    var orderedDict = OrderedDictionary<String, Any>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(employeeList)
        configCountryCodePicker()
        
        fullNameTxt.delegate = self
        fullNameTxt.keyboardType = .alphabet
        emailTxt.delegate = self
        timePicker.datePickerMode = .time
        if #available(iOS 13.4, *) {
            timePicker.preferredDatePickerStyle = .wheels
        } else {
            
        }
        timePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
        
        prefferdTimeTxt.inputView = timePicker
        datePicker.datePickerMode = .date
        datePicker.minimumDate = Date()
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        } else {
            
        }
        datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
       prefferdDateTxt.inputView = datePicker
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        
//        prefferdDateTxt.text = dateFormatter.string(from: datePicker.date)
        
        timePicker.datePickerMode = .time
        timePicker.addTarget(self, action: #selector(timeChanged), for: .valueChanged)
        // Set up the input view for the text field
        prefferdTimeTxt.inputView = timePicker
    }
    
    func configCountryCodePicker(){
        self.countryCodePicker = CountryPickerView()
        self.countryCodePicker?.delegate = self
        self.countryCodePicker?.dataSource = self
    }
    
    @objc func dateChanged() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        prefferdDateTxt.text = dateFormatter.string(from: datePicker.date)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        PrefferedDate.resignFirstResponder()
        return true
    }
    
    @IBAction func onClickBackBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onClickStateDropDownBt(_ sender: Any) {
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
        
        let option4 = UIAlertAction(title: "Arizona", style: .default) { (action) in
            self.stateTxt.text = "Arkansas"
            print("Option 2 selected")
        }
        
        
        
        let option5 = UIAlertAction(title: "California", style: .default) { (action) in
            self.stateTxt.text = "California"
            print("Option 2 selected")
        }
        let option6 = UIAlertAction(title: "Colorado", style: .default) { (action) in
            self.stateTxt.text = "Colorado"
            print("Option 2 selected")
        }
        let option7 = UIAlertAction(title: "Connecticut", style: .default) { (action) in
            self.stateTxt.text = "Connecticut"
            print("Option 2 selected")
        }
        
        let option8 = UIAlertAction(title: "Delaware", style: .default) { (action) in
            self.stateTxt.text = "Delaware"
            print("Option 2 selected")
        }
        let option9 = UIAlertAction(title: "District of columbia", style: .default) { (action) in
            self.stateTxt.text = "District of columbia"
            print("Option 2 selected")
        }
        let option10 = UIAlertAction(title: "Florida", style: .default) { (action) in
            self.stateTxt.text = "Florida"
            print("Option 2 selected")
        }
        let option11 = UIAlertAction(title: "Georgia", style: .default) { (action) in
            self.stateTxt.text = "Georgia"
            print("Option 2 selected")
        }
        let option12 = UIAlertAction(title: "Hawali", style: .default) { (action) in
            self.stateTxt.text = "Hawali"
            print("Option 2 selected")
        }
        let option13 = UIAlertAction(title: "Idaho", style: .default) { (action) in
            self.stateTxt.text = "Idaho"
            print("Option 2 selected")
        }
        let option14 = UIAlertAction(title: "Illinois", style: .default) { (action) in
            self.stateTxt.text = "Illinois"
            print("Option 2 selected")
        }
        let option15 = UIAlertAction(title: "Indiana", style: .default) { (action) in
            self.stateTxt.text = "Indiana"
            print("Option 2 selected")
        }
        let option16 = UIAlertAction(title: "Lowa", style: .default) { (action) in
            self.stateTxt.text = "Lowa"
            print("Option 2 selected")
        }
        let option17 = UIAlertAction(title: "Kansas", style: .default) { (action) in
            self.stateTxt.text = "Kansas"
            print("Option 2 selected")
        }
        let option18 = UIAlertAction(title: "Kentucky", style: .default) { (action) in
            self.stateTxt.text = "Kentucky"
            print("Option 2 selected")
        }
        let option19 = UIAlertAction(title: "Louisiana", style: .default) { (action) in
            self.stateTxt.text = "Louisiana"
            print("Option 2 selected")
        }
        let option20 = UIAlertAction(title: "Maine", style: .default) { (action) in
            self.stateTxt.text = "Maine"
            print("Option 2 selected")
        }
        let option21 = UIAlertAction(title: "Maryland", style: .default) { (action) in
            self.stateTxt.text = "Maryland"
            print("Option 2 selected")
        }
        let option22 = UIAlertAction(title: "Massachusetts", style: .default) { (action) in
            self.stateTxt.text = "Massachusetts"
            print("Option 2 selected")
        }
        let option23 = UIAlertAction(title: "Michigan", style: .default) { (action) in
            self.stateTxt.text = "Michigan"
            print("Option 2 selected")
        }
        let option24 = UIAlertAction(title: "Minnesota", style: .default) { (action) in
            self.stateTxt.text = "Minnesota"
            print("Option 2 selected")
        }
        let option25 = UIAlertAction(title: "Mississippi", style: .default) { (action) in
            self.stateTxt.text = "Mississippi"
            print("Option 2 selected")
        }
        let option26 = UIAlertAction(title: "Missouri", style: .default) { (action) in
            self.stateTxt.text = "Missouri"
            print("Option 2 selected")
        }
        let option27 = UIAlertAction(title: "Montana", style: .default) { (action) in
            self.stateTxt.text = "Montana"
            print("Option 2 selected")
        }
        let option28 = UIAlertAction(title: "Nebraska", style: .default) { (action) in
            self.stateTxt.text = "Nebraska"
            print("Option 2 selected")
        }
        let option29 = UIAlertAction(title: "Nevada", style: .default) { (action) in
            self.stateTxt.text = "Nevada"
            print("Option 2 selected")
        }
        let option30 = UIAlertAction(title: "New hampshire", style: .default) { (action) in
            self.stateTxt.text = "New hampshire"
            print("Option 2 selected")
        }
        let option31 = UIAlertAction(title: "New jersey", style: .default) { (action) in
            self.stateTxt.text = "New jersey"
            print("Option 2 selected")
        }
        let option32 = UIAlertAction(title: "New Mexico", style: .default) { (action) in
            self.stateTxt.text = "New Mexico"
            print("Option 2 selected")
        }
        
        let option33 = UIAlertAction(title: "New york", style: .default) { (action) in
            self.stateTxt.text = "New york"
            print("Option 2 selected")
        }
        let option34 = UIAlertAction(title: "North Dacota", style: .default) { (action) in
            self.stateTxt.text = "North Dacota"
            print("Option 2 selected")
        }
        let option35 = UIAlertAction(title: "Ohio", style: .default) { (action) in
            self.stateTxt.text = "Ohio"
            print("Option 2 selected")
        }
        let option36 = UIAlertAction(title: "Oklahoma", style: .default) { (action) in
            self.stateTxt.text = "Oklahoma"
            print("Option 2 selected")
        }
        
        let option37 = UIAlertAction(title: "Oregon", style: .default) { (action) in self.stateTxt.text = "Oregon"
            print("Option 2 selected")
        }
        
        let option38 = UIAlertAction(title: "Pennsylvania", style: .default) { (action) in
            self.stateTxt.text = "Pennsylvania"
            print("Option 2 selected")
        }
        
        let option39 = UIAlertAction(title: "Puerto rico", style: .default) { (action) in
            self.stateTxt.text = "Puerto rico"
            print("Option 2 selected")
        }
        
        let option40 = UIAlertAction(title: "Oklahoma", style: .default) { (action) in
            self.stateTxt.text = "Oklahoma"
            print("Option 2 selected")
        }
        
        let option41 = UIAlertAction(title: "Rhode island", style: .default) { (action) in
            self.stateTxt.text = "Rhode island"
            print("Option 2 selected")
        }
        
        let option42 = UIAlertAction(title: "South carolina", style: .default) { (action) in
            self.stateTxt.text = "South carolina"
            print("Option 2 selected")
        }
        
        let option43 = UIAlertAction(title: "Southdacota", style: .default) { (action) in
            self.stateTxt.text = "Southdacota"
            print("Option 2 selected")
        }
        
        let option44 = UIAlertAction(title: "Tennesse", style: .default) { (action) in
            self.stateTxt.text = "Tennesse"
            print("Option 2 selected")
        }
        
        let option45 = UIAlertAction(title: "Texas", style: .default) { (action) in
            self.stateTxt.text = "Texas"
            print("Option 2 selected")
        }
        let option46 = UIAlertAction(title: "Utah", style: .default) { (action) in
            self.stateTxt.text = "Utah"
            print("Option 2 selected")
        }
        let option47 = UIAlertAction(title: "Vermont", style: .default) { (action) in
            self.stateTxt.text = "Vermont"
            print("Option 2 selected")
        }
        let option48 = UIAlertAction(title: "Vergin island", style: .default) { (action) in
            self.stateTxt.text = "Vergin island"
            print("Option 2 selected")
        }
        
        let option49 = UIAlertAction(title: "Verginia", style: .default) { (action) in
            self.stateTxt.text = "Verginia"
            print("Option 2 selected")
        }
        let option50 = UIAlertAction(title: "Washington", style: .default) { (action) in
            self.stateTxt.text = "Washington"
            print("Option 2 selected")
        }
        let option51 = UIAlertAction(title: "West verginia", style: .default) { (action) in
            self.stateTxt.text = "West verginia"
            print("Option 2 selected")
        }
        let option52 = UIAlertAction(title: "Wisconsin", style: .default) { (action) in
            self.stateTxt.text = "Wisconsin"
            print("Option 2 selected")
        }
        let option53 = UIAlertAction(title: "Wyoming", style: .default) { (action) in
            self.stateTxt.text = "Wyoming"
            print("Option 2 selected")
        }
        
        // Initialize the cancel action
        cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            // Handle cancel selected
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
        actionSheet.addAction(option53)
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
    
    @IBAction func onClickcountryCodeBtn(_ sender: Any) {
        self.countryCodePicker?.showCountriesList(from: self)
        
        //        let cancel: UIAlertAction
        //
        //        let actionSheet = UIAlertController(title: "Choose an option", message: nil, preferredStyle: .actionSheet)
        //
        //        let option1 = UIAlertAction(title: "Phone", style: .default) { (action) in
        //            self.countryCodePicker?.showCountriesList(from: self)
        ////           self.countryCodeLbl.text
        ////            self.countryCodeLbl.text = self.employeeList.first?.countryCode ?? ""
        //            print("Option 1 selected")
        //        }
        //
        //        cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
        //            // Handle cancel selected
        //            print("Cancelled")
        //        }
        //        actionSheet.addAction(option1)
        //
        //
        //        actionSheet.popoverPresentationController?.sourceView = self.view
        //        actionSheet.popoverPresentationController?.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
        //
        //        present(actionSheet, animated: true, completion: nil)
    }
    
    @IBAction func onClickPreferContacted(_ sender: Any) {
        let cancel: UIAlertAction
        
        let actionSheet = UIAlertController(title: "Choose an option", message: nil, preferredStyle: .actionSheet)
        
        let option1 = UIAlertAction(title: "Phone", style: .default) { (action) in
            self.contactxt.text = "Phone"
            print("Option 1 selected")
        }
        
        let option2 = UIAlertAction(title: "Email", style: .default) { (action) in
            self.contactxt.text = "Email"
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
        
        present(actionSheet, animated: true, completion: nil)
    }
    
    @IBAction func onClickTimeToCall(_ sender: Any) {
        let cancel: UIAlertAction
        let actionSheet = UIAlertController(title: "Choose an option", message: nil, preferredStyle: .actionSheet)
        
        let option1 = UIAlertAction(title: "AnyTime", style: .default) { (action) in
            self.bestTimeToCallTxt.text = "AnyTime"
            print("Option 1 selected")
        }
        
        let option2 = UIAlertAction(title: "Morning at Home", style: .default) { (action) in
            self.bestTimeToCallTxt.text = "Morning at Home"
            print("Option 2 selected")
        }
        
        let option3 = UIAlertAction(title: "Morning at Work", style: .default) { (action) in
            self.bestTimeToCallTxt.text = "Morning at Work"
            print("Option 2 selected")
        }
        
        let option4 = UIAlertAction(title: "Afternoon at Home", style: .default) { (action) in
            self.bestTimeToCallTxt.text = "Afternoon at Home"
            print("Option 2 selected")
        }
        
        let option5 = UIAlertAction(title: "Afternoon at Work", style: .default) { (action) in
            self.bestTimeToCallTxt.text = "Afternoon at Work"
            print("Option 2 selected")
        }
        
        let option6 = UIAlertAction(title: "Evening at Home", style: .default) { (action) in
            self.bestTimeToCallTxt.text = "Evening at Home"
            print("Option 2 selected")
        }
        
        let option7 = UIAlertAction(title: "Evening at Work", style: .default) { (action) in
            self.bestTimeToCallTxt.text = "Evening at Work"
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
        
        actionSheet.addAction(cancel)
        actionSheet.popoverPresentationController?.sourceView = self.view
        actionSheet.popoverPresentationController?.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
        present(actionSheet, animated: true, completion: nil)
    }
    
    @IBAction func onClickUploadPictures(_ sender: Any) {
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
                self?.pickedImageUrl = imgUrl
                
            }
            self?.SignatureImageView.image = value
        }
        
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true, completion: nil)
        //        self.present(vc, animated: true)
    }
    
    
    @IBAction func onClickPrefferdTimeBtn(_ sender: Any) {
        prefferdTimeTxt.becomeFirstResponder()
    }
    @objc func timeChanged() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        prefferdTimeTxt.text = dateFormatter.string(from: timePicker.date)
    }
    
    //        let dateFormatter = DateFormatter()
    //        dateFormatter.timeStyle = .full
    //        dateFormatter.dateStyle = .
    //        self.prefferdTimeTxt.text = dateFormatter.string(from:         timePicker.date)
    //        prefferdTimeTxt.becomeFirstResponder()
    
    @objc func TimeChanged() {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .full
        self.prefferdTimeTxt.text = dateFormatter.string(from: timePicker.date)
    }
    
    @IBAction func onClickSubmitBtn(_ sender: Any) {
        //        navigateToNextScreen()
        hideKeyboard()
        if validateTextFields() {
            submitFormData()
        } else {
            print("Validation failed. Please check the fields.")
        }
    }
    
    func validateTextFields() -> Bool {
        var isValid = true
        
        if !isValidInput(textField: fullNameTxt, errorMessage: "Enter Full Name") {
            isValid = false
        }
        
        else if !isValidInput(textField: companyNameTxt, errorMessage: "Enter Company Name") {
            isValid = false
        }
        //
        //        else  if !isValidInput(textField: positionInCmpnyTxt, errorMessage: "Enter Position in Company") {
        //            isValid = false
        //        }
        
        else if !isValidInput(textField: companyAddressTxt, errorMessage: "Enter Company Address") {
            isValid = false
        }
        
        else  if !isValidInput(textField: cityTxt, errorMessage: "Enter City") {
            isValid = false
        }
        
        //        else if !isValidInput(textField: stateTxt, errorMessage: "Enter State") {
        //            isValid = false
        //        }
        
        else if !isValidInput(textField: zipCodeTxt, errorMessage: "Enter Zip Code") {
            isValid = false
        }
        
        else if !isValidInput(textField: phoneNumberTxt, errorMessage: "Enter Phone Number") {
            isValid = false
        }
        
        else if  phoneNumberTxt.text?.isValidPhone() == false {
            isValid = false
            makeToast("Please enter 10 digit Phone Number")
        }
        
        else  if !isValidInput(textField: emailTxt, errorMessage: "Enter Email") {
            isValid = false
        }
        
        else if  emailTxt.text?.isValidEmail() == false {
            isValid = false
            makeToast("Please enter valid email")
        }
        
        else if !isValidInput(textField: contactxt, errorMessage: "Enter How Do You Prefer To be Contacted") {
            isValid = false
        }
        
        else if !isValidInput(textField: bestTimeToCallTxt, errorMessage: "Enter Best Time To Call") {
            isValid = false
        }
        
        //        else  if !isValidInput(textField: PrefferedDate, errorMessage: "Enter Prefferd Date") {
        //            isValid = false
        //        }
        //        else  if !isValidInput(textField: prefferdTimeTxt
        //                               , errorMessage: "Enter Prefferd Time") {
        //            isValid = false
        //        }
        
        else if !isValidInput(textField: positionInYourCmpnyTxt, errorMessage: "Enter What Is Position In Your Company") {
            isValid = false
        }
        
        //        else if !isValidInput(textField: additionaInfoTxt, errorMessage: "Enter Additional Information") {
        //            isValid = false
        //        }
        else
        {
            
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
    
    
    func submitFormData(){
        //        DispatchQueue.main.async {
        //            self.showLoader()
        //        }
        
        let fullName = fullNameTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let companyName = companyNameTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let positionInTheCompany = positionIntHeCompanyTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let companyAddress = companyAddressTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let city = cityTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let state = stateTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let zipCode = zipCodeTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let phoneNo = phoneNumberTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let emailAddress = emailTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let countryCode = countryCodeLbl.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let howDoYoPreferToBeContacted = contactxt.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let bestTimeToCall = bestTimeToCallTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let prefferdDate = prefferdDateTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let prefferedTime = prefferdTimeTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let whatIsPositionInYourCompany = positionInYourCmpnyTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let additionInformation = additionaInfoTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let uploadSignature =
        SignatureImageView.image
        
        
        if  pickedImageUrl == nil{
        makeToast("Please Upload Signature")
        }else{
            let params : [String:Any] = ["Full_Name":fullName!,
                                         "Company_Name":companyName!,
                                         "Position_In_The_Company":positionInTheCompany!,
                                         "Company_Address":companyAddress!,
                                         "City":city!,
                                         "State":state!,
                                         "Zip_Code":zipCode!,
                                         "Email_Address":emailAddress!,
                                         "country_code":countryCode!,
                                         "Phone_number":phoneNo!,
                                         "Prefer_to_be_contacted_by":howDoYoPreferToBeContacted!,
                                         "Best_Time_To_Call":bestTimeToCall!,
                                         "Preferred_Date":prefferdDate!,
                                         "Preferred_Time":prefferedTime!,
                                         "Staffing_Request_Details":whatIsPositionInYourCompany!,
                                         "Additional_Information":additionInformation!,
                                         "signature":pickedImageUrl!.lastPathComponent
            ]
            
            
            orderedDict.insert(key: "Full_Name", value: fullName!)
            orderedDict.insert(key: "Company_Name", value: companyName!)
            orderedDict.insert(key: "Position_In_The_Company", value: positionInTheCompany!)
            orderedDict.insert(key: "Company_Address", value: companyAddress!)
            orderedDict.insert(key: "City", value: city!)
            orderedDict.insert(key: "State", value: state!)
            orderedDict.insert(key: "Zip_Code", value: zipCode!)
            orderedDict.insert(key: "Email_Address", value: emailAddress!)
            orderedDict.insert(key: "country_code", value: countryCode!)
            orderedDict.insert(key: "Phone_number", value: phoneNo!)
            orderedDict.insert(key: "Prefer_to_be_contacted_by", value: howDoYoPreferToBeContacted!)
            orderedDict.insert(key: "Best_Time_To_Call", value: bestTimeToCall!)
            orderedDict.insert(key: "Preferred_Date", value: prefferdDate!)
            orderedDict.insert(key: "Preferred_Time", value: prefferedTime!)
            orderedDict.insert(key: "Staffing_Request_Details", value: whatIsPositionInYourCompany!)
            orderedDict.insert(key: "Additional_Information", value: additionInformation!)
            orderedDict.insert(key: "signature", value: pickedImageUrl!.lastPathComponent)
            
            self.requestNativeImageUpload(param: orderedDict)
//            self.requestNativeImageUpload(param: params)
        }
    }
    
//    func requestNativeImageUpload(param:[String:Any]){
//        showLoader()
//        let fullUrl = Urls.employersUrl
//        ServerClass.sharedInstance.sendMultipartRequestToServer(urlString: fullUrl, fileName: "signature", sendJson: param, imageUrl: pickedImageUrl, successBlock: { (json) in
//            print(json)
//            // self.hideLoader()
//            //hideAllProgressOnView(appDelegateInstance.window!)
//            let success = json["status"].stringValue
//            if success  == "success" {
//                DispatchQueue.main.async {
//                    self.hideLoader()
//                }
//                self.navigateToNextScreen()
//            }else{
//                self.hideLoader()
//                self.makeToast(json["message"].stringValue)
////                self.makeToast(json["error"]["serverErrorMessage"].stringValue)
//            }
//
//        }, errorBlock: { (NSError) in
//            self.hideLoader()
//
//        })
//        //         self.hideLoader()
//
//    }
    
    
    
    func requestNativeImageUpload(param:OrderedDictionary<String, Any>){
        showLoader()
        let fullUrl = Urls.employersUrl
        
        ServerClass.sharedInstance.sendFacilityFormSignatureMultipartRequestToServerInOrderedWay(urlString: fullUrl, fileName: "signature",  sendJson: param, imageUrl: pickedImageUrl,  successBlock: { (json) in
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
    
    
    
    
    
    
    
    
    
    
    
    
    //    func submitFormData() {
    //        DispatchQueue.main.async {
    //            self.showLoader()
    //        }
    //
    //        let fullName = fullNameTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines)
    //        let companyName = companyNameTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines)
    //        let positionInTheCompany = positionIntHeCompanyTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines)
    //        let companyAddress = companyAddressTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines)
    //        let city = cityTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines)
    //        let state = stateTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines)
    //        let zipCode = zipCodeTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines)
    //        let phoneNo = phoneNumberTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines)
    //        let emailAddress = emailTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines)
    //        let countryCode = countryCodeLbl.text?.trimmingCharacters(in: .whitespacesAndNewlines)
    //        let howDoYoPreferToBeContacted = contactxt.text?.trimmingCharacters(in: .whitespacesAndNewlines)
    //        let bestTimeToCall = bestTimeToCallTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines)
    //        let prefferdDate = prefferdDateTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines)
    //        let prefferedTime = prefferdTimeTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines)
    //        let whatIsPositionInYourCompany = positionInYourCmpnyTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines)
    //        let additionInformation = additionaInfoTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines)
    //
    //        Task{
    //            do{
    //                let response = try await apiCallServices.postOperation(requestMethod: .post, params: EmployersRequest( fullName: fullName, companyName: companyName, positionInTheCompany: positionInTheCompany ,companyAddress: companyAddress , city: city, state: state , zipCode: zipCode ,  emailAddress : emailAddress, countryCode : countryCode, phoneNumber: phoneNo , preferToBeContactedBy:  howDoYoPreferToBeContacted , bestTimeToCall: bestTimeToCall , preferredDate: prefferdDate , preferredTime: prefferedTime , staffingRequestDetails: whatIsPositionInYourCompany , additionalInformation: additionInformation ), requestUrl: Urls.employersUrl, response: EmployeeResponse.self)
    //                   print(response)
    //
    //                if  response.status == "success"{
    //                    DispatchQueue.main.async {
    //                        self.hideLoader()
    //                    }
    //                    print(self.employeeList.first?.countryCode)
    //                    self.navigateToNextScreen()
    //                }
    //                else
    //                {
    //                    DispatchQueue.main.async {
    //                        self.hideLoader()
    //                    }
    //                    self.makeToast(response.message ?? "")
    //                }
    //
    //            }
    //            catch{
    //                DispatchQueue.main.async {
    //                self.hideLoader()
    //                }
    //                print("failed")
    //                print(error.localizedDescription)
    //            }
    //        }
    //    }
    
    func navigateToNextScreen(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let popupVC = storyboard.instantiateViewController(withIdentifier: "SubmitPopupVC") as? SubmitPopupVC {
            popupVC.pushVCDelagate = self
            popupVC.modalPresentationStyle = .overFullScreen
            present(popupVC, animated: true, completion: nil)
            //        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            //        let vc = storyBoard.instantiateViewController(withIdentifier: "SubmitPopupVC") as! SubmitPopupVC
            //        vc.hidesBottomBarWhenPushed = true
            //        vc.modalPresentationStyle = .fullScreen
            //        vc.modalTransitionStyle = .crossDissolve
            //        self.navigationController?.present(vc, animated: true)
        }
        
    }
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
    
}
@available(iOS 15.0, *)
extension NurseEmployersVC :OpenAbotherVcDelegate {
    func openVC(setValue: String) {
        self.performNavigationToNextScreen()
    }
    
    func performNavigationToNextScreen() {
        let nextViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainVC") as! MainVC
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
}
@available(iOS 15.0, *)
extension NurseEmployersVC: CountryPickerViewDelegate, CountryPickerViewDataSource{
    func countryPickerView(_ countryPickerView: CountryPickerView, didSelectCountry country: Country) {
        self.countryCodeLbl.text = country.phoneCode
        //        if self.isFrom == "Phone" {
        //            txtCountryCode.text = country.phoneCode
        //        } else if self.isFrom == "Country" {
        //            countryTxt.text = country.name
        //        }
    }
    
    func navigationTitle(in countryPickerView: CountryPickerView) -> String? {
        return "Select your country"
    }
    
    
}
// Latest code 27/02/2024 8:21pm
