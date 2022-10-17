//
//  RegisterDataBody.swift
//  WTF App
//
//  Created by DUCH Chamroeun on 17/10/22.
//

import Foundation

struct RegisterDataBody: Codable {
    var username: String?
    var password: String?
    var fullName: String?
    var dateOfBirth: String?
}

extension RegisterDataBody {
    public var isAllFieldsValid: Bool {
        guard let _ = username,
              let _ = password,
              let _ = fullName,
              let _ = dateOfBirth else {
            return false
        }
        return true
    }
    
    public func isPasswordMatch(_ password: String) -> Bool {
        return self.password == password
    }
}
