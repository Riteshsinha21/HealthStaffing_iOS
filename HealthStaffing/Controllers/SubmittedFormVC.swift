//
//  SubmittedFormVC.swift
//  HealthStaffing
//
//  Created by Chawtech on 04/03/24.
//

import UIKit

@available(iOS 15.0, *)
class SubmittedFormVC: UIViewController , UITableViewDelegate , UITableViewDataSource  {
    
    var submitFormList = [SubmitTimeSheetListData]()
    
    @IBOutlet weak var tableView: UITableView!
     
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
        let userId = UserDefaults.standard.getUserID()
        let submitTimeSheetListRequest = SubmitTimeSheetListRequest(userID: userId)
        submitTimeSheetListRequestToServer(request: submitTimeSheetListRequest)
    }
    
    // Api for SubmitTimeSheetList
    private func submitTimeSheetListRequestToServer(request: SubmitTimeSheetListRequest){
        DispatchQueue.main.async {
            showLoading()
        }
        
        let submitTimeSheetListResources = SubmitTimeSheetListResource()
        
        submitTimeSheetListResources.submitTimeSheetList(request: request) { (response) in
            if response.success == "true"{
                hideLoading()
                print(response)
                //                self.dateArr = response.data?.datearray ?? []
                //                self.totalWorkHrs = response.data?.totalWeekHour ?? ""
                //                self.timesheetId = response.data?.timesheetID ?? ""
                //                self.savedFormList = response.data
                //
                
                self.submitFormList = response.data
                DispatchQueue.main.async {
                    hideLoading()
                    //  self.totalHrsForDayLbl.text = response.data?.totalWeekHour ?? ""
                    self.tableView.reloadData()
                }
                
            } else {
                DispatchQueue.main.async {
                    hideLoading()
                    self.makeToast(response.message ?? "")
                }
            }
            
        } onError: { (error) in
            DispatchQueue.main.async {
                hideLoading()
                self.makeToast(error.localizedDescription)
//              self.makeToast(error.localizedDescription)
            }
        }
    }
    
    @IBAction func onClickInReviewBtn(_ sender: Any) {
//        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyBoard.instantiateViewController(withIdentifier: "WeeklyTimeSheetVC") as! WeeklyTimeSheetVC
//        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func onClickBackBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return submitFormList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SubmittedFormTableViewCell", for: indexPath) as! SubmittedFormTableViewCell
        
        cell.selectionStyle = .none
        
        let info = self.submitFormList[indexPath.row]
        let startDate = info.startDate
        let endDate = info.endDate
        let timeSheetId = info.timesheetID
        let totalHrs = info.totalHour
        let review = info.status
        
        cell.startDateLbl.text = startDate
        cell.outDateLbl.text = endDate
        cell.timeSheetLbl.text = "Timesheet - 00" + (timeSheetId ?? "")
        cell.overTimeHrsLbl.text = ( totalHrs ?? "") + " Hours"
        cell.reviewBtn.setTitle(review, for: .normal)
        cell.reviewBtn.layer.cornerRadius = 10
        cell.reviewLbl.layer.cornerRadius = 10
        cell.layer.cornerRadius = 20
        cell.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)//CGSizeMake(0.0, -2.0)
        cell.layer.shadowOpacity = 0.3
        

        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "WeeklyTimeSheetVC") as! WeeklyTimeSheetVC
        vc.comingFrom = "SubmittedFormVCEmployee"
        let data = submitFormList[indexPath.row]
        vc.timesheetId = data.timesheetID ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
}
