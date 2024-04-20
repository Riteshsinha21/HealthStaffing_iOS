//
//  SubmittedFormTableViewCell.swift
//  HealthStaffing
//
//  Created by Chawtech on 05/03/24.
//

import UIKit

class SubmittedFormTableViewCell: UITableViewCell {

    @IBOutlet weak var cellBGView: UIView!
    
    @IBOutlet weak var reviewBtn: UIButton!
    
    @IBOutlet weak var reviewLbl: UILabel!
    
    @IBOutlet weak var timeSheetLbl: UILabel!
        @IBOutlet weak var inReviewBtn: UIButton!
        @IBOutlet weak var startDateLbl: UILabel!
        @IBOutlet weak var outDateLbl: UILabel!
        @IBOutlet weak var overTimeHrsLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cellBGView.layer.cornerRadius = 20
        reviewBtn.layer.cornerRadius = 10
        
        reviewBtn.clipsToBounds = true
        reviewBtn.layer.masksToBounds = true
        
        reviewLbl.layer.cornerRadius = 10
        reviewLbl.clipsToBounds = true
        reviewLbl.layer.masksToBounds = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
