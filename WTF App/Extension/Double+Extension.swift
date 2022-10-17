//
//  Double+Extension.swift
//  WTF App
//
//  Created by DUCH Chamroeun on 15/10/22.
//

import Foundation

extension Double {
    
    public var toPrice: String {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "en-US")
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 1
        
        return formatter.string(from: self as NSNumber) ?? "$0.0"
    }
}
