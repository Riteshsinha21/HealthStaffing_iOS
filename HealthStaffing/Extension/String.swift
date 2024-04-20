//
//  String.swift
//  HealthStaffing
//
//  Created by CTS on 31/01/24.
//

import Foundation
import UIKit

extension String{
    
    func isValidEmail() -> Bool{
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
    
    func trim() -> String {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    
    
    func isValidPhone() -> Bool
    {
        let mobileRegEx = NSString(format:"[0-9]{%d}",10) as String
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", mobileRegEx)
        return phoneTest.evaluate(with: self)
    }
    
    func isValidPassword() -> Bool{
        if self.count >= 6 {
            return true
        }else{
            return false
        }
    }
    
    public var withoutHtml: String {
        guard let data = self.data(using: .utf8) else {
            return self
        }
        
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        
        guard let attributedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil) else {
            return self
        }
        
        return attributedString.string
    }
    
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            let paragraphStyle = NSMutableParagraphStyle()
                        paragraphStyle.alignment = .left
            let content = try NSMutableAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
            
            content.addAttributes([NSAttributedString.Key.paragraphStyle: paragraphStyle,
                                   NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15),
                                   NSAttributedString.Key.foregroundColor: UIColor.white],
                                  range: NSMakeRange(0, content.length))
            
            return content
            
        } catch {
            return nil
        }
    }
    
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
    
}


public func getDirectoryPath() -> String {
    let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
    let documentsDirectory = paths[0]
    return documentsDirectory
}

public func saveImageDocumentDirectory(usedImage:UIImage)
{
    let fileManager = FileManager.default
    let paths = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("temp.jpeg")
    let imageData = usedImage.jpegData(compressionQuality: 0.5)
    fileManager.createFile(atPath: paths as String, contents: imageData, attributes: nil)
}



public func getImageUrl() -> URL? {
    let url = URL(fileURLWithPath: (getDirectoryPath() as NSString).appendingPathComponent("temp.jpeg"))
    return url
}


struct TYF_AlertText {
    static let internetConnection = "Please check your internet connection !"
    static let alert  = "Alert"
}

extension UIView {
    func roundCornersRadius(corners: UIRectCorner, radius: CGFloat) {
        let maskPath = UIBezierPath(roundedRect: bounds,
                                    byRoundingCorners: corners,
                                    cornerRadii: CGSize(width: radius, height: radius))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = maskPath.cgPath
        layer.mask = maskLayer
    }
    func setGradientBackground(view:UIView) {
        let colorTop =  UIColor(red: 4.0/255.0, green: 130/255.0, blue: 214.0/255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 0.0/255.0, green: 76/255.0, blue: 126.0/255.0, alpha: 1.0).cgColor

        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = view.bounds
        view.clipsToBounds = true
        view.layer.insertSublayer(gradientLayer, at:0)
    }
}
