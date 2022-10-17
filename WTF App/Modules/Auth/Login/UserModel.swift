//
//  UserModel.swift
//  WTF App
//
//  Created by DUCH Chamroeun on 15/10/22.
//

import Foundation

struct UserModel: Codable {
    let userId: String
    let fullName: String?
    let dateOfBirth: String?
    let token: String
}
