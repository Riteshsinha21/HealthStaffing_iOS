//
//  WeeklyTimeSheetTableViewCell.swift
//  HealthStaffing
//
//  Created by Chawtech on 01/03/24.
//

import UIKit

class WeeklyTimeSheetTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellTotalHrsLbl: UILabel!
    @IBOutlet weak var CellBGView: UIView!
    @IBOutlet weak var cellDateLbl: UILabel!
    
    @IBOutlet weak var startDateLbl: UILabel!
    
    @IBOutlet weak var endDateLbl: UILabel!
    
    @IBOutlet weak var regularHrsLbl: UILabel!
    
    @IBOutlet weak var lunchHrsLbl: UILabel!
    
    @IBOutlet weak var overTimeLbl: UILabel!
    
    
    @IBOutlet weak var editBtn: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.CellBGView.layer.cornerRadius = 20
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    
}
