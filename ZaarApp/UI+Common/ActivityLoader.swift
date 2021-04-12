//
//  ActivityLoader.swift
//  ZaarApp
//
//  Created by apple on 01/04/21.
//

import Foundation
import SVProgressHUD
struct ActivityLoader {
    static func show(){
        (UIApplication.shared.delegate as? AppDelegate)?.window?.isUserInteractionEnabled = false
        SVProgressHUD.show()
    }
    static func hide(){
        (UIApplication.shared.delegate as? AppDelegate)?.window?.isUserInteractionEnabled = true
        SVProgressHUD.dismiss()
    }
    static func showError(message: String){
        (UIApplication.shared.delegate as? AppDelegate)?.window?.isUserInteractionEnabled = true
        SVProgressHUD.showError(withStatus: message)
    }
    static func showSuccess(message: String){
        (UIApplication.shared.delegate as? AppDelegate)?.window?.isUserInteractionEnabled = true
        SVProgressHUD.showSuccess(withStatus: message)
    }
}
