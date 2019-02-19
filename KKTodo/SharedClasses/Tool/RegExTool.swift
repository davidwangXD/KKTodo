//
//  RegexTool.swift
//  KKTodo
//
//  Created by David Wang on 2019/2/18.
//  Copyright © 2019 David Wang. All rights reserved.
//

import Foundation

@objc class RegExTool: NSObject {
    @objc class func validateEmail(_ content: String) -> Bool {
        let regEx = "^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regEx)
        
        return predicate.evaluate(with: content)
    }
    
    @objc class func validatePassword(_ content: String) -> Bool {
        let regEx = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{6,12}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regEx)
        
        return predicate.evaluate(with: content)
    }
    
    @objc class func validateCellphone(_ content: String) -> Bool {
        let regEx = "^[\\d]{10,10}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regEx)
        
        return predicate.evaluate(with: content)
    }
    
    @objc class func validateGeneral(_ content: String) -> Bool {
        return (content.count > 0)
    }
    
    @objc class func validateDigits(_ content: String) -> Bool {
        let regEx = "^[\\d]*$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regEx)
        
        return predicate.evaluate(with: content)
    }
    
    @objc class func processPhoneNumber(_ number: String) -> String {
        var result = number.replacingOccurrences(of: "+886", with: "0")
        result = number.replacingOccurrences(of: "886", with: "0")
        result = number.replacingOccurrences(of: "-", with: "")
        result = number.replacingOccurrences(of: " ", with: "")
        result = number.replacingOccurrences(of: " ", with: "")
        return result
    }
}
