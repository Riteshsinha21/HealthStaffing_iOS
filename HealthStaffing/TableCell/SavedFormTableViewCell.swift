//
//  SavedFormTableViewCell.swift
//  HealthStaffing
//
//  Created by Chawtech on 05/03/24.
//

import UIKit

class SavedFormTableViewCell: UITableViewCell {
    
    @IBOutlet weak var startDateLbl: UILabel!
     
     @IBOutlet weak var endDateLbl: UILabel!
     
     
     @IBOutlet weak var timeSheetIdLbl: UILabel!
     
     
     @IBOutlet weak var totalHrsLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cellBGView.layer.cornerRadius = 20
    }

    @IBOutlet weak var cellBGView: UIView!
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
