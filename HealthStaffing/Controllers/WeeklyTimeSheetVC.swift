//
//  WeeklyTimeSheetVC.swift
//  HealthStaffing
//
//  Created by Chawtech on 01/03/24.
//

import UIKit

@available(iOS 15.0, *)
class WeeklyTimeSheetVC: UIViewController , UITableViewDelegate , UITableViewDataSource {
    
    @IBOutlet weak var submitViewHeight: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var totalHrsForDayView: UIView!
    
    @IBOutlet weak var totalHrsTimeInnerView: UIView!
    
    @IBOutlet weak var timeSheetLbl: UILabel!
    
    @IBOutlet weak var totalHrsForDayLbl: UILabel!
    
    
    @IBOutlet weak var submitBtn: UIButton!
    
    @IBOutlet weak var submitView: UIView!
    
    
    var weekArr = [String]()
    var dayArr = ["Sunday","Monday","Tuesday", "Wednesday", "Thursday","Friday","Saturday"]
    
    var dateArr = [Datearray]()
    var managerDateArr = [ManagerReviewDetailArray]()
    
    var totalWorkHrs = ""
    var timesheetId = ""
    var startDate = ""
    var comingFrom = ""
    var endDate = ""
    var employeeId = ""
    var shouldSubmitForm = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(endDate)
        self.submitBtn.layer.cornerRadius = 20
        //        print(timesheetId)
        //        let timeSheetID = timesheetIdd.timesheetID
        //        self.timeSheetLbl.text = ("Timesheet  -00 ") + (timeSheetID ?? "")
//        self.totalHrsForDayView.layer.cornerRadius = 20
        
        self.totalHrsTimeInnerView.layer.cornerRadius = 10
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.submitView.roundCornersRadius(corners: .allCorners, radius: 20)
        self.submitView.setGradientBackground(view: submitView)
        
        self.totalHrsForDayView.layer.cornerRadius = 10
        self.totalHrsForDayView.layer.shadowOffset = CGSize(width: 0.0, height: -3.0)
        self.totalHrsForDayView.layer.shadowOpacity = 0.3
       
        
        if comingFrom == "SubmittedFormVC" || comingFrom == "SubmittedFormVCEmployee"{
            self.submitView.isHidden = true
        } else {
            self.submitView.isHidden = false
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let userRole = UserDefaults.standard.getUserRole()
        if userRole == "employee" {
            self.checkActivationOfSubmitBtn()
        } else {
            self.shouldSubmitForm = true
        }
        
        let userId = UserDefaults.standard.getUserID()
        if comingFrom == "NewFormVC" || comingFrom == "SavedForm"{
            let NewFormRequest = NewFormRequest(startDate: self.startDate, userID: userId)
            sendNewFormRequestToServer(request: NewFormRequest)
        }else if comingFrom == "ManagerReviewFormVC"  {
            let managerReviewDetailRequest = ManagerReviewDetailTSRequest(managerID: userId, employeeID: employeeId, timesheetID: timesheetId)
            managerReviewDetailFormRequestToServer(request: managerReviewDetailRequest )
        }else if comingFrom == "SubmittedFormVC"  {
//            let managerReviewDetailRequest = ManagerReviewDetailTSRequest(managerID: userId, employeeID: employeeId, timesheetID: timesheetId)
            let managerReviewDetailRequest = ManagerSubmitFormDetailTSRequest(employeeID: employeeId, timesheetID: timesheetId)
            managerSubmitDetailFormRequestToServer(request: managerReviewDetailRequest )
        }
        else{
            let viewSubmitTimeSheetRequest = ViewSubmitTimeSheetRequest(userID: userId, timesheetID: timesheetId)
            viewSubmittedFormRequestToServer(request: viewSubmitTimeSheetRequest)
        }
    }
    
    func checkActivationOfSubmitBtn() {
        let currentDate = Date()

        // Create a date formatter to parse the date string
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"

        let currentDateString = dateFormatter.string(from: currentDate)

        if currentDateString == self.endDate {
            shouldSubmitForm = true
        } else {
            
            if let date = dateFormatter.date(from: self.endDate) {
                // Get the current date
                let currentDate = Date()

                // Compare the dates
                if date > currentDate {
                    print("The date is later than the current date.")
                    shouldSubmitForm = false
                } else {
                    print("The date is earlier than the current date.")
                    shouldSubmitForm = true
                }
            } else {
                print("Invalid date string.")
            }
            
        }
        
    }
    
    
    //  NewFormApi
    private func sendNewFormRequestToServer(request: NewFormRequest){
        DispatchQueue.main.async {
            showLoading()
        }
        let NewFormResources = NewFormResource()
        
        NewFormResources.newForm(request: request) { (response) in
            if response.success == "true"{
                print(response)
                self.dateArr = response.data?.datearray ?? []
                self.totalWorkHrs = response.data?.totalWeekHour ?? ""
                self.timesheetId = response.data?.timesheetID ?? ""
                UserDefaults.standard.setSaveCount(saveCount: response.data?.saveCount ?? "")
                DispatchQueue.main.async {
                    hideLoading()
                    self.totalHrsForDayLbl.text = response.data?.totalWeekHour ?? ""
                    
                    if let number = Int(self.timesheetId) {
                        let formattedTimeSheetId = String(format: "%03d", number)
                        self.timeSheetLbl.text = "Timesheet - \(formattedTimeSheetId)"
                    } else {
                        print("Invalid number string")
                    }
                    
//                    self.timeSheetLbl.text = ("Timesheet  -00 ") + ( self.timesheetId)
                    self.tableView.reloadData()
                }
            }else{
                DispatchQueue.main.async {
                    hideLoading()
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    if let popupVC = storyboard.instantiateViewController(withIdentifier: "SubmittedTimesheetVC") as? SubmittedTimesheetVC{
                        popupVC.modalPresentationStyle = .overFullScreen
                        popupVC.pushNewFormVCDelagate = self
                        self.present(popupVC, animated: true, completion: nil)
                    }
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
    
    private func viewSubmittedFormRequestToServer(request: ViewSubmitTimeSheetRequest){
        DispatchQueue.main.async {
            showLoading()
        }
        
        let viewSubmittedResources = NewFormResource()
        viewSubmittedResources.ViewSubmitTimeSheet(request: request) { (response) in
            if response.success == "true"{
                self.dateArr = response.data?.datearray ?? []
                self.totalWorkHrs = response.data?.totalWeekHour ?? ""
                self.timesheetId = response.data?.timesheetID ?? ""
                
                DispatchQueue.main.async {
                    hideLoading()
                    self.totalHrsForDayLbl.text = response.data?.totalWeekHour ?? ""
                    
                    if let number = Int(self.timesheetId) {
                        let formattedTimeSheetId = String(format: "%03d", number)
                        self.timeSheetLbl.text = "Timesheet - \(formattedTimeSheetId)"
                    } else {
                        print("Invalid number string")
                    }
                    
//                    self.timeSheetLbl.text = ("Timesheet  -00 ") + ( self.timesheetId)
                    self.tableView.reloadData()
                }
            }else{
                DispatchQueue.main.async {
                    self.makeToast(response.message ?? "")
                    hideLoading()
                }
            }
            
        } onError: { (error) in
            DispatchQueue.main.async {
                hideLoading()
                self.makeToast(error.localizedDescription)
            }
        }
    }
    
    
    
    //  ManagerReviewDetailApi
    
    private func managerReviewDetailFormRequestToServer(request: ManagerReviewDetailTSRequest){
        DispatchQueue.main.async {
            showLoading()
        }
        let ManagerReviewDetailTSResources = ManagerReviewDetailTSResource()
        
        ManagerReviewDetailTSResources.ManagerReviewDetailTS(request: request) { (response) in
            if response.success == "true"{
                print(response)
                self.managerDateArr = response.data?.datearray ?? []
                self.totalWorkHrs = response.data?.totalWeekHour ?? ""
                self.timesheetId = response.data?.timesheetID ?? ""
                //                UserDefaults.standard.setSaveCount(saveCount: response.data?.saveCount ?? "")
                DispatchQueue.main.async {
                    hideLoading()
                    self.totalHrsForDayLbl.text = response.data?.totalWeekHour ?? ""
                    
                    if let number = Int(self.timesheetId) {
                        let formattedTimeSheetId = String(format: "%03d", number)
                        self.timeSheetLbl.text = "Timesheet - \(formattedTimeSheetId)"
                    } else {
                        print("Invalid number string")
                    }
                    
//                    self.timeSheetLbl.text = ("Timesheet  -00 ") + ( self.timesheetId)
                    self.tableView.reloadData()
                }
            }else{
                DispatchQueue.main.async {
                    hideLoading()
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    if let popupVC = storyboard.instantiateViewController(withIdentifier: "SubmittedTimesheetVC") as? SubmittedTimesheetVC{
                        popupVC.modalPresentationStyle = .overFullScreen
                        popupVC.pushNewFormVCDelagate = self
                        self.present(popupVC, animated: true, completion: nil)
                    }
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
    
    private func managerSubmitDetailFormRequestToServer(request: ManagerSubmitFormDetailTSRequest){
        DispatchQueue.main.async {
            showLoading()
        }
        let ManagerReviewDetailTSResources = ManagerSubmittedDetailTSResource()
        
        ManagerReviewDetailTSResources.ManagerSubmitDetailTS(request: request) { (response) in
            if response.success == "true"{
                print(response)
                self.managerDateArr = response.data?.datearray ?? []
                self.totalWorkHrs = response.data?.totalWeekHour ?? ""
                self.timesheetId = response.data?.timesheetID ?? ""
                //                UserDefaults.standard.setSaveCount(saveCount: response.data?.saveCount ?? "")
                DispatchQueue.main.async {
                    hideLoading()
                    self.totalHrsForDayLbl.text = response.data?.totalWeekHour ?? ""
                    
                    if let number = Int(self.timesheetId) {
                        let formattedTimeSheetId = String(format: "%03d", number)
                        self.timeSheetLbl.text = "Timesheet - \(formattedTimeSheetId)"
                    } else {
                        print("Invalid number string")
                    }
                    
//                    self.timeSheetLbl.text = ("Timesheet  -00 ") + ( self.timesheetId)
                    self.tableView.reloadData()
                }
            }else{
                DispatchQueue.main.async {
                    hideLoading()
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    if let popupVC = storyboard.instantiateViewController(withIdentifier: "SubmittedTimesheetVC") as? SubmittedTimesheetVC{
                        popupVC.modalPresentationStyle = .overFullScreen
                        popupVC.pushNewFormVCDelagate = self
                        self.present(popupVC, animated: true, completion: nil)
                    }
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
    
    @IBAction func onClickBackBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onClickEdit(_ sender: UIButton) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "TimeSheetEditVC") as! TimeSheetEditVC
        if comingFrom == "ManagerReviewFormVC"{
            vc.managerDateObj = managerDateArr[sender.tag]
            let data = managerDateArr[sender.tag]
            vc.employeeId = employeeId
            vc.comingFrom = "ManagerReviewFormVC"
        }else{
            vc.dateObj = dateArr[sender.tag]
            let data = dateArr[sender.tag]
        }
        
        vc.timesheetId = timesheetId
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func onClickSubmit(_ sender: Any) {
        
        if shouldSubmitForm {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "SingnatureVC") as! SingnatureVC
            if comingFrom == "ManagerReviewFormVC" {
                vc.timeSheetId = timesheetId
                vc.employeeId = employeeId
                vc.comingFrom = "ManagerReviewFormVC"
            }else{
                vc.timeSheetId = timesheetId
                print( vc.timeSheetId)
            }
            
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            ShowAlert(message: "This form is only available for submission on Saturdays every week.")
        }
        
        
        
    }
    
    @IBAction func onClickSave(_ sender: Any) {
        let userId = UserDefaults.standard.getUserID()
        let timeSheetId = timesheetId
        print(timeSheetId)
        let savedTimeSheetRequest = SavedTimeSheetRequest(userID: userId, timesheetID: timeSheetId)
        saveTimeSheetRequestToServer(request: savedTimeSheetRequest)
    }
    
    
    private func saveTimeSheetRequestToServer(request: SavedTimeSheetRequest){
        DispatchQueue.main.async {
            showLoading()
        }
        let savedTimeSheetResources = SavedTimeSheetResource()
        savedTimeSheetResources.savedTimeSheet(request: request) { (response) in
            if response.success == "true"{
                //                let savedFormCount = UserDefaults.standard.value(forKey: "savedFormCount") as! String
                //                let savedFormCountInt = Int(savedFormCount)
                //                let updatedavedFormCountInt = (savedFormCountInt ?? 0) + 1
                //                UserDefaults.standard.setValue("\(updatedavedFormCountInt)", forKey: "savedFormCount")
                UserDefaults.standard.setValue(response.data.save_count ?? "", forKey: "savedFormCount")
                DispatchQueue.main.async {
                    self.makeToast(response.message ?? "")
                    hideLoading()
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    
                    let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
                    self.navigationController!.popToViewController(viewControllers[viewControllers.count - 2], animated: true)
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //        return 7
        if comingFrom == "ManagerReviewFormVC" || comingFrom == "SubmittedFormVC"{
            return managerDateArr.count
        }
        else{
            return self.dateArr.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeeklyTimeSheetTableViewCell", for: indexPath) as! WeeklyTimeSheetTableViewCell
        
        cell.selectionStyle = .none
        
        if comingFrom == "ManagerReviewFormVC"  || comingFrom == "SubmittedFormVC"{
            let dateInfo = self.managerDateArr[indexPath.row]
            let date = dateInfo.date ?? ""
            let day = dateInfo.day ?? ""
            cell.cellDateLbl.text = "\(date) (\(day))"
            cell.cellTotalHrsLbl.text =  "Total -" + (dateInfo.totalHours ?? "") + " Hours"
            cell.startDateLbl.text = dateInfo.startTime ?? ""
            cell.endDateLbl.text =   dateInfo.outTime ?? ""
            cell.regularHrsLbl.text = dateInfo.regularHours ?? ""
            cell.lunchHrsLbl.text = dateInfo.lunchHours ?? ""
            cell.overTimeLbl.text = dateInfo.overtimeHours ?? ""
            
            cell.layer.cornerRadius = 20
            cell.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)//CGSizeMake(0.0, -2.0)
            cell.layer.shadowOpacity = 0.3
            cell.editBtn.tag = indexPath.row
            
        }
        
        else{
            let dateInfo = self.dateArr[indexPath.row]
            let date = dateInfo.date ?? ""
            let day = dateInfo.day ?? ""
            
            cell.cellDateLbl.text = "\(date) (\(day))"
            cell.cellTotalHrsLbl.text =  "Total -" + (dateInfo.totalHours ?? "") + " Hours"
            cell.startDateLbl.text = dateInfo.startTime ?? ""
            cell.endDateLbl.text = dateInfo.outTime ?? ""
            cell.regularHrsLbl.text = dateInfo.regularHours ?? ""
            cell.lunchHrsLbl.text = dateInfo.lunchHours ?? ""
            cell.overTimeLbl.text = dateInfo.overtimeHours ?? ""
            
            cell.layer.cornerRadius = 20
            cell.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)//CGSizeMake(0.0, -2.0)
            cell.layer.shadowOpacity = 0.3
            cell.editBtn.tag = indexPath.row
        }
        
        if comingFrom == "SubmittedFormVC" || comingFrom == "SubmittedFormVCEmployee"{
            cell.editBtn.isHidden = true
            
        }else{
            cell.editBtn.isHidden = false
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250//290
    }
    
}

@available(iOS 15.0, *)
extension WeeklyTimeSheetVC :OpenNewFormVcDelegate {
    func openNewFormVC(setValue: String) {
        self.performNavigationToNextScreen()
    }
    
    func performNavigationToNextScreen() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
            self.navigationController!.popToViewController(viewControllers[viewControllers.count - 2], animated: true)
        }
    }
    
}

