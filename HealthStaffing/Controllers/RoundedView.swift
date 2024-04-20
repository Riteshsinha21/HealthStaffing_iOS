//
//  RoundedView.swift
//  HealthStaffing
//
//  Created by CTS on 15/03/24.
//

import UIKit

class RoundedView: UIView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Calculate the corner radius based on half of the view's height
        layer.cornerRadius = bounds.height / 2
        
        // Clip subviews to the rounded corners
        layer.masksToBounds = true
    }
    
}
