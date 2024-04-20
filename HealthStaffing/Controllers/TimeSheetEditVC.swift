//
//  TimeSheetEditVC.swift
//  HealthStaffing
//
//  Created by Chawtech on 01/03/24.
//

import UIKit

@available(iOS 15.0, *)
class TimeSheetEditVC: UIViewController {
    
    @IBOutlet weak var TotalHrsForDayView: UIView!
    @IBOutlet weak var innnerHrsTimeView: UIView!
    @IBOutlet weak var dayTxt: UITextField!
    @IBOutlet weak var dateTxt: UITextField!
    @IBOutlet weak var statTimeTxt: UITextField!
    @IBOutlet weak var outTimeTxt: UITextField!
    @IBOutlet weak var regularHrsTxt: UITextField!
    @IBOutlet weak var lunchHrsTxt: AfterOneSecondTextField!
    @IBOutlet weak var startDateHrsTxt: UITextField!
    @IBOutlet weak var overTimeHrsTxt: AfterOneSecondTextField!
    @IBOutlet weak var TotalTimeLBL: UILabel!
    @IBOutlet weak var submitView: UIView!
    
    var selectedOptions: [String] = []
    let DatePicker = UIDatePicker()
    let timePicker = UIDatePicker()
    let outTimePicker = UIDatePicker()
    let regularHrsPicker = UIDatePicker()
    let lunchHrsPicker = UIDatePicker()
    let startDateHrsPicker = UIDatePicker()
    
    var dateObj:Datearray?
    var managerDateObj:ManagerReviewDetailArray?
    var timesheetId = ""
    var employeeId = " "
    
    var startTimeCalc = ""
    var endTimeCalc = ""
    var comingFrom = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overTimeHrsTxt.actionClosure = {
            // Call
            if !(self.lunchHrsTxt.text!.isEmpty) || !(self.statTimeTxt.text!.isEmpty) || !(self.outTimeTxt.text!.isEmpty) {
                self.calculateDiff()
            }
        }
        lunchHrsTxt.actionClosure = {
            // Call
            if !(self.overTimeHrsTxt.text!.isEmpty) || !(self.statTimeTxt.text!.isEmpty) || !(self.outTimeTxt.text!.isEmpty) {
                self.calculateDiff()
            }
        }
        
        self.setData()
        configureDatePicker()
        configureOutDatePicker()
        configureLunchDatePicker()
        DatePicker.datePickerMode = .date
        timePicker.datePickerMode = .time
        outTimePicker.datePickerMode = .time
        regularHrsPicker.datePickerMode = .time
        lunchHrsPicker.datePickerMode = .time
        startDateHrsPicker.datePickerMode = .time
        self.innnerHrsTimeView.layer.cornerRadius = 10
        self.TotalHrsForDayView.layer.cornerRadius = 20
        
        statTimeTxt.delegate = self
        outTimeTxt.delegate = self
        //        lunchHrsTxt.delegate = self
        //        overTimeHrsTxt.delegate = self
        
        if #available(iOS 13.4, *) {
            DatePicker.preferredDatePickerStyle = .wheels
        } else {
            
        }
        
        DatePicker.addTarget(self, action: #selector(dateChange), for: .valueChanged)
        dateTxt.inputView = DatePicker
        
        if #available(iOS 13.4, *) {
            timePicker.preferredDatePickerStyle = .wheels
        } else {
            
        }
        
        if #available(iOS 13.4, *) {
            outTimePicker.preferredDatePickerStyle = .wheels
        } else {
            
        }
        
        if #available(iOS 13.4, *) {
            regularHrsPicker.preferredDatePickerStyle = .wheels
        } else {
            
        }
        if #available(iOS 13.4, *) {
            lunchHrsPicker.preferredDatePickerStyle = .wheels
        } else {
            
        }
        if #available(iOS 13.4, *) {
            startDateHrsPicker.preferredDatePickerStyle = .wheels
        } else {
            
        }
        
        timePicker.addTarget(self, action: #selector(startTime), for: .valueChanged)
        statTimeTxt.inputView = timePicker
        
        outTimePicker.addTarget(self, action: #selector(outTimeFormatter), for: .valueChanged)
        outTimeTxt.inputView = outTimePicker
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.submitView.roundCornersRadius(corners: .allCorners, radius: 20)
        self.submitView.setGradientBackground(view: submitView)
    }
    
    func convertTo24HourFormat(from dateString: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = "HH:mm"//"HH:mm"
            //            return dateFormatter.string(from: date)
//            return (self.dateObj?.date ?? "") + " " + dateFormatter.string(from: date)
            return (self.getCurrentdate()) + " " + dateFormatter.string(from: date)
        } else {
            return nil
        }
    }
    
    func getCurrentdate() -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy"
            let currentDateAsString = dateFormatter.string(from: Date())
            return(currentDateAsString)
        }

    func setData() {
        if comingFrom == "ManagerReviewFormVC"{
            let startDateStr = "\(self.managerDateObj?.startTime ?? "")"
            if let twentyFourHourFormatStartDate = convertTo24HourFormat(from: startDateStr) {
                self.startTimeCalc = twentyFourHourFormatStartDate
            } else {
                print("Invalid date string")
            }
            let endDateStr = self.managerDateObj?.outTime ?? ""
            if let twentyFourHourFormatEndDate = convertTo24HourFormat(from: endDateStr) {
                self.endTimeCalc = twentyFourHourFormatEndDate
            } else {
                print("Invalid date string")
            }
            print(self.startTimeCalc)
            print(self.endTimeCalc)
            self.dayTxt.text = self.managerDateObj?.day
            self.dateTxt.text = self.managerDateObj?.date
            self.statTimeTxt.text = self.managerDateObj?.startTime
            self.outTimeTxt.text = self.managerDateObj?.outTime
            self.regularHrsTxt.text = self.managerDateObj?.regularHours
            self.lunchHrsTxt.text = self.managerDateObj?.lunchHours
            self.overTimeHrsTxt.text = self.managerDateObj?.overtimeHours
            self.TotalTimeLBL.text = self.managerDateObj?.totalHours

        }
        
        else{
            
            let startDateStr = "\(self.dateObj?.startTime ?? "")"
            if let twentyFourHourFormatStartDate = convertTo24HourFormat(from: startDateStr) {
                self.startTimeCalc = twentyFourHourFormatStartDate
            } else {
                print("Invalid date string")
            }
            let endDateStr = self.dateObj?.outTime ?? ""
            if let twentyFourHourFormatEndDate = convertTo24HourFormat(from: endDateStr) {
                self.endTimeCalc = twentyFourHourFormatEndDate
            } else {
                print("Invalid date string")
            }
            print(self.startTimeCalc)
            print(self.endTimeCalc)
            self.dayTxt.text = self.dateObj?.day
            self.dateTxt.text = self.dateObj?.date
            self.statTimeTxt.text = self.dateObj?.startTime
            self.outTimeTxt.text = self.dateObj?.outTime
            self.regularHrsTxt.text = self.dateObj?.regularHours
            self.lunchHrsTxt.text = self.dateObj?.lunchHours
            self.overTimeHrsTxt.text = self.dateObj?.overtimeHours
            self.TotalTimeLBL.text = self.dateObj?.totalHours
        }
    }
    
    @objc func dateChange() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateTxt.text = dateFormatter.string(from: DatePicker.date)
    }
    
    @objc func startTime() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        startTimeCalc = dateFormatter.string(from: timePicker.date)
        
        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateFormat = "hh:mm a"
        statTimeTxt.text = dateFormatter2.string(from: timePicker.date)
    }
    
    @objc func outTimeFormatter() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        endTimeCalc = dateFormatter.string(from: outTimePicker.date)
        
        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateFormat = "hh:mm a"
        outTimeTxt.text = dateFormatter2.string(from: outTimePicker.date)
    }
    
    @objc func regularHrsFormatter() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        regularHrsTxt.text = dateFormatter.string(from: regularHrsPicker.date)
    }
    
    @objc func lunchHrsFormatter() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        lunchHrsTxt.text = dateFormatter.string(from: lunchHrsPicker.date)
    }
    
    @objc func startDateHrsFormatter() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        startDateHrsTxt.text = dateFormatter.string(from: startDateHrsPicker.date)
    }
    
    @IBAction func onClickBackBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onClickSubmit(_ sender: Any) {
        guard let day = dayTxt.text, !day.isEmpty else {
            makeToast("Day not entered.")
            return
        }
        
        guard let date = dateTxt.text, !date.isEmpty else {
            makeToast("Date not entered.")
            return
        }
        guard let startTime = statTimeTxt.text, !startTime.isEmpty else {
            makeToast("Please select Start Time")
            return
        }
        guard let outTime = outTimeTxt.text, !outTime.isEmpty else {
            makeToast("Please select Out Time")
            return
        }
        guard let regularTime = regularHrsTxt.text, !regularTime.isEmpty else {
            makeToast("Regular hours not entered")
            return
        }
        
        guard let lunchTime = lunchHrsTxt.text, !lunchTime.isEmpty else {
            makeToast("Lunch time not entered")
            return
        }
        
        guard let overTime = overTimeHrsTxt.text, !overTime.isEmpty else {
            makeToast("Lunch time not entered")
            return
        }
        
        guard let totalHrs = TotalTimeLBL.text, !totalHrs.isEmpty else {
            makeToast("Lunch time not entered")
            return
        }

        let userId = UserDefaults.standard.getUserID()
      
        
        let timeSheetId = timesheetId
        let employeeId = employeeId
        print(timeSheetId)
        if comingFrom == "ManagerReviewFormVC"{
            let TimeSheetRequest = TimeSheetListRequest(userID: employeeId, timesheetID: timeSheetId, date: date, day: day, startTime: startTime, outTime: outTime, regularHours: regularTime, lunchHours: lunchTime, overtimeHours: overTime, totalHour: totalHrs)
            addManagerTimeSheetRequestToServer(request: TimeSheetRequest)
        }
        else{
            let TimeSheetRequest = TimeSheetListRequest(userID: userId, timesheetID: timeSheetId, date: date, day: day, startTime: startTime, outTime: outTime, regularHours: regularTime, lunchHours: lunchTime, overtimeHours: overTime, totalHour: totalHrs)
            addTimeSheetRequestToServer(request: TimeSheetRequest)
        }
    }
    
    
    private func addTimeSheetRequestToServer(request: TimeSheetListRequest){
        DispatchQueue.main.async {
            showLoading()
        }
        let timeSheetResources = TimeSheetResource()
        timeSheetResources.timeSheet(request: request) { (response) in
            if response.success == "true"{
                print(response)
                DispatchQueue.main.async {
                    hideLoading()
                    self.navigationController?.popViewController(animated: true)
                }
            }else{
                DispatchQueue.main.async {
                    hideLoading()
                    self.makeToast(response.message ?? "")
                }
            }
            
        } onError: { (error) in
            DispatchQueue.main.async {
                hideLoading()
                self.makeToast(error.localizedDescription)
            }
        }
    }
    
    
//   ManagerSubmitApi
    
    
    private func addManagerTimeSheetRequestToServer(request: TimeSheetListRequest){
        DispatchQueue.main.async {
            showLoading()
        }
        let timeSheetResources = TimeSheetResource()
        timeSheetResources.timeSheet(request: request) { (response) in
            if response.success == "true"{
                print(response)
                DispatchQueue.main.async {
                    hideLoading()
                    self.navigationController?.popViewController(animated: true)
                }
            }else{
                DispatchQueue.main.async {
                    hideLoading()
                    self.makeToast(response.message ?? "")
                }
            }
            
        } onError: { (error) in
            DispatchQueue.main.async {
                hideLoading()
                self.makeToast(error.localizedDescription)
            }
        }
    }
    
    
    
    
    
    
    
    
    
    @IBAction func onClickDay(_ sender: Any) {
        let cancel: UIAlertAction
        
        let actionSheet = UIAlertController(title: "Choose an option", message: nil, preferredStyle: .actionSheet)
        
        let option1 = UIAlertAction(title: "Sun", style: .default) { (action) in
            self.dayTxt.text = "Sun"
            print("Option 1 selected")
        }
        let option2 = UIAlertAction(title: "Mon", style: .default) { (action) in
            self.dayTxt.text = "Mon"
            print("Option 2 selected")
        }
        let option3 = UIAlertAction(title: "Tue", style: .default) { (action) in
            self.dayTxt.text = "Tue"
            print("Option 2 selected")
        }
        let option4 = UIAlertAction(title: "Wed", style: .default) { (action) in
            self.dayTxt.text = "Wed"
            print("Option 2 selected")
        }
        let option5 = UIAlertAction(title: "Thurs", style: .default) { (action) in
            self.dayTxt.text = "Thurs"
            print("Option 2 selected")
        }
        
        let option6 = UIAlertAction(title: "Fri", style: .default) { (action) in
            self.dayTxt.text = "Fri"
            print("Option 2 selected")
        }
        let option7 = UIAlertAction(title: "Sat", style: .default) { (action) in
            self.dayTxt.text = "Sat"
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
        actionSheet.addAction(option6)
        actionSheet.addAction(option7)
        
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
    
    func calculateDiff() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        let startDateString = self.startTimeCalc ?? ""
        let endDateString = self.endTimeCalc ?? ""
        
        guard let adjustedEndTime = adjustEndTimeIfNeeded(startTime: startDateString, endTime: endDateString) else {
            fatalError("Invalid date format")
        }
        guard let startDate = dateFormatter.date(from: startDateString),
              let endDate = dateFormatter.date(from: adjustedEndTime) else {
            fatalError("Invalid date format")
        }
        // Get the calendar instance
        let calendar = Calendar.current
        let minuteDifference = calendar.dateComponents([.minute], from: startDate, to: endDate).minute ?? 0
        
        let otherTime = Int(self.overTimeHrsTxt.text ?? "0") ?? 0
        let lunchTime = Int(self.lunchHrsTxt.text ?? "0") ?? 0
        let totalOtherTime = otherTime + lunchTime
        var differenceTime =  abs(minuteDifference) - totalOtherTime
        differenceTime = abs(differenceTime)
        print(differenceTime)
        let (hours, minutes) = self.convertMinutesToHoursMinutes(differenceTime)
        
        let formattedHour = String(format: "%02d", hours)
        let formattedMins = String(format: "%02d", minutes)
        
        self.TotalTimeLBL.text = "\(formattedHour):\(formattedMins)"
        print("####$$$$$$$$******\(self.TotalTimeLBL.text)")
    }
    func convertMinutesToHoursMinutes(_ totalMinutes: Int) -> (hours: Int, minutes: Int) {
        var hours = totalMinutes / 60
        var minutes = totalMinutes % 60
        //        if hours == 0 {
        //            hours = 00
        //        }
        //        if minutes == 0 {
        //            minutes = 00
        //        }
        return (hours, minutes)
    }
    func adjustEndTimeIfNeeded(startTime: String, endTime: String) -> String? {
        // Create date formatter
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        guard let startDate = dateFormatter.date(from: startTime),
              let endDate = dateFormatter.date(from: endTime) else {
            print("Invalid time format")
            return nil
        }
        // Compare start time and end time
        if endDate < startDate {
            // If end time is less than start time, add 24 hours to the end time
            let adjustedEndTime = Calendar.current.date(byAdding: .hour, value: 24, to: endDate)!
            return dateFormatter.string(from: adjustedEndTime)
        } else {
            // If end time is not less than start time, return the original end time
            return endTime
        }
    }
    
    func configureDatePicker(){
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(onClickEndDoneButton))
        
        toolBar.setItems([space, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        toolBar.sizeToFit()
        statTimeTxt.inputAccessoryView = toolBar
        let datePickerView = UIDatePicker()
        datePickerView.datePickerMode = UIDatePicker.Mode.date
    }
    
    func configureOutDatePicker(){
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(onClickOutDoneButton))
        toolBar.setItems([space, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        toolBar.sizeToFit()
        outTimeTxt.inputAccessoryView = toolBar
        let datePickerView = UIDatePicker()
        datePickerView.datePickerMode = UIDatePicker.Mode.date
    }
    
    func configureLunchDatePicker(){
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(onClickLunchDoneButton))
        toolBar.setItems([space, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        toolBar.sizeToFit()
        lunchHrsTxt.inputAccessoryView = toolBar
        let datePickerView = UIDatePicker()
        datePickerView.datePickerMode = UIDatePicker.Mode.date
    }
    @objc func onClickEndDoneButton() {
        self.view.endEditing(true)
        if !(lunchHrsTxt.text!.isEmpty) || !(overTimeHrsTxt.text!.isEmpty) {
            self.calculateDiff()
        }
        
    }
    @objc func onClickOutDoneButton() {
        self.view.endEditing(true)
        if !(lunchHrsTxt.text!.isEmpty) || !(overTimeHrsTxt.text!.isEmpty) {
            self.calculateDiff()
        }
        //        endDateTxt.text = dateFormatter.string(from: saturdayValue)
    }
    @objc func onClickLunchDoneButton() {
        self.view.endEditing(true)
    }
}

@available(iOS 15.0, *)
extension TimeSheetEditVC: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == overTimeHrsTxt {
            guard let startTime = statTimeTxt.text, !startTime.isEmpty else {
                makeToast("Please select Start Time")
                return false
            }
            
            guard let outTime = outTimeTxt.text, !outTime.isEmpty else {
                makeToast("Please select Out Time")
                return false
            }
            
            guard let lunchTime = lunchHrsTxt.text, !lunchTime.isEmpty else {
                makeToast("Please select Lunch Time")
                return false
            }
            
            
        }
        return true
    }
}


/*
 func findDateDiff(time1Str: String, time2Str: String, lunchHrs: Double, others: Double) -> (String , String) {
 let timeformatter = DateFormatter()
 timeformatter.dateFormat = "hh:mm a"
 
 guard let time1 = timeformatter.date(from: time1Str),
 let time2 = timeformatter.date(from: time2Str) else { return ("","") }
 
 let secondsToSubstract = (lunchHrs * 60) + (others * 60)
 let interval = time2.timeIntervalSince(time1)
 let updatedInterval = interval - secondsToSubstract
 let hour = updatedInterval / 3600;
 let minute = updatedInterval.truncatingRemainder(dividingBy: 3600) / 60
 let intervalInt = Int(updatedInterval)
 //        return "\(intervalInt < 0 ? "-" : "+") \(Int(hour)) Hours \(Int(minute)) Minutes"
 return ("\(Int(hour))" , "\(Int(minute))")
 }
 */
