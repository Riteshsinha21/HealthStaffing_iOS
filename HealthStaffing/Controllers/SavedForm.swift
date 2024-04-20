//
//  SavedForm.swift
//  HealthStaffing
//
//  Created by Chawtech on 04/03/24.
//

import UIKit
@available(iOS 15.0, *)
class SavedForm: UIViewController ,UITableViewDelegate ,UITableViewDataSource{

    @IBOutlet weak var tableView: UITableView!
    
    var savedFormList = [SavedTimeSheetListData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
        
        let userId = UserDefaults.standard.getUserID()
        let savedTimeSheetListRequest = SavedTimeSheetListRequest(userID: userId)
        savedTimeSheetListRequestToServer(request: savedTimeSheetListRequest)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    private func savedTimeSheetListRequestToServer(request: SavedTimeSheetListRequest){
        DispatchQueue.main.async {
            showLoading()
        }
        let savedTimeSheetListResources = SavedTimeSheetListResource()
        
        savedTimeSheetListResources.savedTimeSheetList(request: request) { (response) in
            if response.success == "true"{
                hideLoading()
                print(response)
//                self.dateArr = response.data?.datearray ?? []
//                self.totalWorkHrs = response.data?.totalWeekHour ?? ""
//                self.timesheetId = response.data?.timesheetID ?? ""
                self.savedFormList = response.data
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
    
    @IBAction func onClickBackBtn(_ sender: Any) {
    self.navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedFormList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SavedFormTableViewCell", for: indexPath) as! SavedFormTableViewCell
        
        cell.selectionStyle = .none
        cell.layer.cornerRadius = 20
        cell.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)//CGSizeMake(0.0, -2.0)
  //      cell.layer.shadowColor = CGColor(red: 255/3, green: 255/6, blue: 255/5, alpha: 1)
        cell.layer.shadowOpacity = 0.3
        
        let info = self.savedFormList[indexPath.row]
        let startDate = info.startDate
        let endDate = info.endDate
        let timeSheetId = info.timesheetID
        let totalHrs = info.totalHour
        
        cell.startDateLbl.text = startDate
        cell.endDateLbl.text = endDate
        cell.timeSheetIdLbl.text = "Timesheet - 00" + (timeSheetId ?? "")
        cell.totalHrsLbl.text = "Total -" + ( totalHrs ?? "") + " Hours"
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let info = self.savedFormList[indexPath.row]
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "WeeklyTimeSheetVC") as! WeeklyTimeSheetVC
        vc.startDate = info.startDate ?? ""
        vc.endDate = info.endDate ?? ""
        vc.timesheetId = info.timesheetID ?? ""
        vc.comingFrom = "SavedForm"
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         return 155
    }
}


 
