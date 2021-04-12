//
//  UITextFieldProperties.swift
//  ZaarApp
//
//  Created by apple on 30/03/21.
//

import Foundation
import UIKit
extension UITextField{
    @IBInspectable var placeHolderTextColor: UIColor? {
            set {
                let placeholderText = self.placeholder != nil ? self.placeholder! : ""
                attributedPlaceholder = NSAttributedString(string:placeholderText, attributes:[NSAttributedString.Key.foregroundColor: newValue!])
            }
            get{
                return self.placeHolderTextColor
            }
        }
   
     func setLeftPaddingPoints(_ amount:CGFloat){
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
            self.leftView = paddingView
            self.leftViewMode = .always
        }
        
        func setRightPaddingPoints(_ amount:CGFloat) {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
            self.rightView = paddingView
            self.rightViewMode = .always
        }
        
//        func setIcon(_ image: UIImage) {
//           let iconView = UIImageView(frame:
//                          CGRect(x: 10, y: 5, width: 20, height: 20))
//           iconView.image = image
//           let iconContainerView: UIView = UIView(frame:
//                          CGRect(x: 20, y: 0, width: 30, height: 30))
//           iconContainerView.addSubview(iconView)
//           leftView = iconContainerView
//           leftViewMode = .always
//        }
    func addLeftImage(textField: UITextField, andImage img: UIImage){
        let leftImageView = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width: img.size.width, height: img.size.width))
        leftImageView.image = img
        textField.leftView = leftImageView
        textField.leftViewMode = .always
        
    }
        
        

       
}
