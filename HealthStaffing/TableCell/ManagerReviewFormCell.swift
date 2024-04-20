//
//  ManagerReviewFormCell.swift
//  HealthStaffing
//
//  Created by Chawtech on 21/03/24.
//

import UIKit

class ManagerReviewFormCell: UITableViewCell {

    
    @IBOutlet weak var bgView: UIView!
    
    @IBOutlet weak var employeeName: UILabel!
    
    
    @IBOutlet weak var companyNameLbl: UILabel!
    
    
    @IBOutlet weak var startDateLbl: UILabel!
    
    
    @IBOutlet weak var endDateLbl: UILabel!
    
    
    @IBOutlet weak var timeSheetIdLbl: UILabel!
    
    
    @IBOutlet weak var tottalHrsLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.bgView.layer.cornerRadius = 20
        
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

      
    }

}
