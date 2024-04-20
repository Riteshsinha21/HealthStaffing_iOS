//
//  SignatureView.swift
//  TeamPlayer
//
//  Created by CTS on 22/02/24.
//

import UIKit

class SignatureView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    private var path = UIBezierPath()
        private var strokeColor = UIColor.black
        private var lineWidth: CGFloat = 2.0

        override func draw(_ rect: CGRect) {
            strokeColor.setStroke()
            path.stroke()
        }

        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            guard let touch = touches.first else { return }
            path.move(to: touch.location(in: self))
        }

        override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
            guard let touch = touches.first else { return }
            path.addLine(to: touch.location(in: self))
            setNeedsDisplay()
        }

        func clear() {
            path.removeAllPoints()
            setNeedsDisplay()
        }

        func getImage() -> UIImage? {
            UIGraphicsBeginImageContextWithOptions(bounds.size, false, UIScreen.main.scale)
            defer { UIGraphicsEndImageContext() }
            drawHierarchy(in: bounds, afterScreenUpdates: true)
            return UIGraphicsGetImageFromCurrentImageContext()
        }

}
