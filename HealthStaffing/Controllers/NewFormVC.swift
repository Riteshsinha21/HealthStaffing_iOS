//
//  NewFormVC.swift
//  HealthStaffing
//
//  Created by Chawtech on 01/03/24.
//

import UIKit

@available(iOS 15.0, *)
class NewFormVC: UIViewController , UITextFieldDelegate {
    
    @IBOutlet weak var startDateTxt: UITextField!
    @IBOutlet weak var endDateTxt: UITextField!
    
    @IBOutlet weak var submitView: UIView!
    @IBOutlet weak var submitButton: UIButton!
    
    let StartDatePicker = UIDatePicker()
    let endDatePicker = UIDatePicker()
    
    var saturdayValue = Date()
    var dateFormatter = DateFormatter()
    
    var dateArr = [Datearray]()
    var totalWorkHrs = ""
    var timesheetId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startDateTxt.delegate = self

        configureDatePicker()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        
        
        StartDatePicker.datePickerMode = .date
        endDatePicker.datePickerMode = .date
        
        
        if #available(iOS 13.4, *) {
            StartDatePicker.preferredDatePickerStyle = .wheels
        } else {
        }
        
        
        if #available(iOS 13.4, *) {
            endDatePicker.preferredDatePickerStyle = .wheels
        } else {
        }
        
        StartDatePicker.addTarget(self, action: #selector(startDateChanged), for: .valueChanged)
        StartDatePicker.maximumDate = Date()
        startDateTxt.inputView = StartDatePicker
        endDateTxt.inputView = endDatePicker
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.submitView.roundCornersRadius(corners: .allCorners, radius: 20)
        self.submitView.setGradientBackground(view: submitView)
    }
    @objc func startDateChanged() {
        dateFormatter.dateFormat = "dd-MM-yyyy"
//        dateFormatter.dateFormat = "MM/dd/yyyy"
        let selectedDate = StartDatePicker.date
        let formattedDate = dateFormatter.string(from: selectedDate)
        startDateTxt.text = formattedDate
        let nextSaturday = self.nextSaturday(atHour: 10, min: 0, today: selectedDate)
        self.saturdayValue = nextSaturday
        print(nextSaturday)
    }
    
    
    @IBAction func doneButtonTapped(_ sender: UIButton) {
        let selectedDate = StartDatePicker.date
        print("Selected date: \(selectedDate)")
        StartDatePicker.resignFirstResponder()
    }
    
    
    @IBAction func onClickSubmit(_ sender: Any) {
        hideKeyboard()
        let startDate = startDateTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let endDate = endDateTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines)
//        let userId = UserDefaults.standard.getUserID()
//        let NewFormRequest = NewFormRequest(startDate: startDate, userID: userId)

        if validateTextFields(){
            //            sendNewFormRequestToServer(request: NewFormRequest)
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "WeeklyTimeSheetVC") as! WeeklyTimeSheetVC
            vc.startDate = startDate ?? ""
            vc.endDate =  endDate ?? ""
            print(vc.endDate)
            vc.comingFrom = "NewFormVC"
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
    //  NewFormApi
//    private func sendNewFormRequestToServer(request: NewFormRequest){
//        DispatchQueue.main.async {
//            showLoading()
//        }
//        let NewFormResources = NewFormResource()
//
//        NewFormResources.newForm(request: request) { (response) in
//            if response.success == "true"{
////                self.dataArr = response.data
//                DispatchQueue.main.async {
//                    hideLoading()
//                    self.startDateTxt.text = ""
////                    self.makeToast("New Password has been sent to your registered
//
//            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//            let vc = storyBoard.instantiateViewController(withIdentifier: "WeeklyTimeSheetVC") as! WeeklyTimeSheetVC
//                    dump(response)
//
//                    self.dateArr = response.data?.datearray ?? []
//                    self.totalWorkHrs = response.data?.totalWeekHour ?? ""
//                    self.timesheetId = response.data?.timesheetID ?? ""
//
//                    vc.dateArr = self.dateArr
//                    vc.totalWorkHrs = self.totalWorkHrs
//                    vc.timesheetId = self.timesheetId
//
//
//          self.navigationController?.pushViewController(vc, animated: true)
//                }
//            }else{
//                DispatchQueue.main.async {
//                    hideLoading()
//                    self.makeToast(response.message ?? "")
//                }
//            }
//
//        } onError: { (error) in
//            DispatchQueue.main.async {
//                hideLoading()
//                self.makeToast(error.localizedDescription)
//            }
//        }
//    }
        
    //Validation TextField
        func validateTextFields() -> Bool {
            var isValid = true
            
            if !isValidInput(textField: startDateTxt, errorMessage: "Enter start date") {
                isValid = false
            }
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
        
    
//    Navigate To NextScreen
    
    func switchToNextScreen(){
    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    let vc = storyBoard.instantiateViewController(withIdentifier: "WeeklyTimeSheetVC") as! WeeklyTimeSheetVC
   self.navigationController?.pushViewController(vc, animated: true)
        
 }
    
        
    @IBAction func onClickBackBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    func nextSaturday(atHour hour: Int, min: Int, today: Date) -> Date {
        let daysToAdd = 7 - (Calendar.current.dateComponents([.weekday], from: today).weekday ?? 0 )
        let nextSaturday = Calendar.current.date(byAdding: .day, value: daysToAdd, to: today)!
        return Calendar.current.date(bySettingHour: hour, minute: min, second: 0, of: nextSaturday)!
    }
    
    func configureDatePicker(){
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(onClickDoneButton))
        toolBar.setItems([space, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        toolBar.sizeToFit()
        startDateTxt.inputAccessoryView = toolBar
        
        let datePickerView = UIDatePicker()
        datePickerView.datePickerMode = UIDatePicker.Mode.date
    }
    
    @objc func onClickDoneButton() {
        self.view.endEditing(true)
        
        endDateTxt.text = dateFormatter.string(from: saturdayValue)
        if endDateTxt.text!.isEmpty {
            dateFormatter.dateFormat = "dd-MM-yyyy"
            let selectedDate = Date()
            let formattedDate = dateFormatter.string(from: selectedDate)
            startDateTxt.text = formattedDate
            let nextSaturday = self.nextSaturday(atHour: 10, min: 0, today: selectedDate)
            self.saturdayValue = nextSaturday
            endDateTxt.text = dateFormatter.string(from: self.saturdayValue)
        }
    }
        //2024-03-16 04:30:00 +0000
//    - timeIntervalSinceReferenceDate : 732256200.0
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == self.startDateTxt {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            formatter.dateFormat = "dd-MM-yyyy"
//            formatter.timeStyle = .medium
            self.startDateTxt.text = formatter.string(from: Date())
        }
        return true
    }

        
}


extension Calendar {
    static let iso8601 = Calendar(identifier: .iso8601)
    static let gregorian = Calendar(identifier: .gregorian)
}
extension Date {
    func byAdding(component: Calendar.Component, value: Int, wrappingComponents: Bool = false, using calendar: Calendar = .current) -> Date? {
        calendar.date(byAdding: component, value: value, to: self, wrappingComponents: wrappingComponents)
    }
    func dateComponents(_ components: Set<Calendar.Component>, using calendar: Calendar = .current) -> DateComponents {
        calendar.dateComponents(components, from: self)
    }
    func startOfWeek(using calendar: Calendar = .current) -> Date {
        calendar.date(from: dateComponents([.yearForWeekOfYear, .weekOfYear], using: calendar))!
    }
    var noon: Date {
        Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
    func daysOfWeek(using calendar: Calendar = .current) -> [Date] {
        let startOfWeek = self.startOfWeek(using: calendar).noon
        return (0...6).map { startOfWeek.byAdding(component: .day, value: $0, using: calendar)! }
    }
}

extension Formatter {
    static let ddMMyyyy: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar(identifier: .iso8601)
        dateFormatter.locale = .init(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "dd.MM.yyyy"
        return dateFormatter
    }()
}

extension Date {
    var ddMMyyyy: String {
        Formatter.ddMMyyyy.string(from: self)
    }
}
