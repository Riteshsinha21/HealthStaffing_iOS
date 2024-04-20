//
//  ManagerReviewFormVC.swift
//  HealthStaffing
//
//  Created by Chawtech on 21/03/24.
//

import UIKit

class ManagerReviewFormVC: UIViewController ,UITableViewDelegate ,UITableViewDataSource {
    
    var managerReviewList = [ManagerReviewTimeSheetData]()
    var managerSubmitList = [ManagerSubmitTSListData]()
    var comingFrom = ""
    
    @IBOutlet weak var headerLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if comingFrom == "ManagerSubmit"{
            let managerId = UserDefaults.standard.getUserID()
            let managerSubmitTimeSheetRequest = ManagerSubmitTSListRequest(managerID: managerId)
            managerSubmitTimeSheetListRequestToServer(request: managerSubmitTimeSheetRequest)
            
        }
        else{
            let managerId = UserDefaults.standard.getUserID()
            let managerReviewTimeSheetRequest = ManagerReviewTimeSheetRequest(managerID: managerId )
            managerReviewTimeSheetListRequestToServer(request: managerReviewTimeSheetRequest)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if comingFrom == "ManagerSubmit" {
            self.headerLbl.text = "Submitted Forms"
        } else {
            self.headerLbl.text = "Forms for Review"
            
        }
    }
    
    
    private func managerReviewTimeSheetListRequestToServer(request: ManagerReviewTimeSheetRequest){
        DispatchQueue.main.async {
            showLoading()
        }
        let managerReviewListResources = ManagerReviewTimeSheetResources()
        
        managerReviewListResources.ManagerReviewTimeSheet(request: request) { (response) in
            if response.success == "true"{
                hideLoading()
                print(response)
                //                self.dateArr = response.data?.datearray ?? []
                //                self.totalWorkHrs = response.data?.totalWeekHour ?? ""
                //                self.timesheetId = response.data?.timesheetID ?? ""
                self.managerReviewList = response.data
                //
                DispatchQueue.main.async {
                    hideLoading()
                    //                  self.totalHrsForDayLbl.text = response.data?.totalWeekHour ?? ""
                    self.tableView.reloadData()
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
    
    private func managerSubmitTimeSheetListRequestToServer(request: ManagerSubmitTSListRequest){
        DispatchQueue.main.async {
            showLoading()
        }
        let managerSubmitListResources = ManagerSubmitTSListResources()
        
        managerSubmitListResources.ManagerSubmitTSList(request: request) { (response) in
            if response.success == "true"{
                hideLoading()
                print(response)
                //                self.dateArr = response.data?.datearray ?? []
                //                self.totalWorkHrs = response.data?.totalWeekHour ?? ""
                //                self.timesheetId = response.data?.timesheetID ?? ""
                self.managerSubmitList = response.data
                //
                DispatchQueue.main.async {
                    hideLoading()
                    //                  self.totalHrsForDayLbl.text = response.data?.totalWeekHour ?? ""
                    self.tableView.reloadData()
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
    
    
    @IBAction func onClickBackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if comingFrom == "ManagerSubmit"{
            return managerSubmitList.count
        }else{
            return managerReviewList.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ManagerReviewFormCell", for: indexPath) as! ManagerReviewFormCell
        
        cell.selectionStyle = .none
        
        if comingFrom == "ManagerSubmit"{
            let info = self.managerSubmitList[indexPath.row]
            let startDate = info.startDate
            let endDate = info.endDate
            let timeSheetId = info.timesheetID
            let totalHrs = info.totalHour
            let employeeName = info.employeeName
            let companyName = info.companyName
            
            cell.startDateLbl.text = startDate
            cell.endDateLbl.text = endDate
            cell.employeeName.text = employeeName
            cell.companyNameLbl.text = companyName
            cell.timeSheetIdLbl.text = "Timesheet - 00" + (timeSheetId ?? "")
            cell.tottalHrsLbl.text = "Total -" + ( totalHrs ?? "") + " Hours"
            
        }
        else{
            
            let info = self.managerReviewList[indexPath.row]
            let startDate = info.startDate
            let endDate = info.endDate
            let timeSheetId = info.timesheetID
            let totalHrs = info.totalHour
            let employeeName = info.employeeName
            let companyName = info.companyName
            
            cell.startDateLbl.text = startDate
            cell.endDateLbl.text = endDate
            cell.employeeName.text = employeeName
            cell.companyNameLbl.text = companyName
            cell.timeSheetIdLbl.text = "Timesheet - 00" + (timeSheetId ?? "")
            cell.tottalHrsLbl.text = "Total -" + ( totalHrs ?? "") + " Hours"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if comingFrom == "ManagerSubmit"{
            
            let info = self.managerSubmitList[indexPath.row]
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            if #available(iOS 15.0, *) {
                let vc = storyBoard.instantiateViewController(withIdentifier: "WeeklyTimeSheetVC") as! WeeklyTimeSheetVC
                //        vc.startDate = info.startDate ?? ""
                vc.timesheetId = info.timesheetID ?? ""
                vc.employeeId = info.employeeID ?? ""
                vc.comingFrom = "SubmittedFormVC"
                vc.endDate = info.endDate ?? ""
                self.navigationController?.pushViewController(vc, animated: true)
            } else {
                
            }
            
        } else {
            
            let info = self.managerReviewList[indexPath.row]
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            if #available(iOS 15.0, *) {
                let vc = storyBoard.instantiateViewController(withIdentifier: "WeeklyTimeSheetVC") as! WeeklyTimeSheetVC
                //        vc.startDate = info.startDate ?? ""
                vc.timesheetId = info.timesheetID ?? ""
                vc.employeeId = info.employeeID ?? ""
                vc.comingFrom = "ManagerReviewFormVC"
                vc.endDate = info.endDate ?? ""
                self.navigationController?.pushViewController(vc, animated: true)
            } else {
                
            }
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
}
