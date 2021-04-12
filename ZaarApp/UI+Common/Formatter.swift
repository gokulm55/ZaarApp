//
//  Formatter.swift
//  ZaarApp
//
//  Created by apple on 12/04/21.
//

import Foundation
extension NSObject{
    
    func myFormatter(date: String) -> String{
           let formatter = DateFormatter()
           formatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
           
           
           let myString = formatter.date(from: date)!
           
           let myFormatter = DateFormatter()
           myFormatter.dateFormat = "MMM d, yyyy"
        //myFormatter.dateFormat = "MMM d, yyyy"
           return myFormatter.string(from: myString)
       }

}
