//
//  OrderHistoryModel.swift
//  WTF App
//
//  Created by DUCH Chamroeun on 15/10/22.
//

import Foundation

struct OrderHistoryModel: Codable {
    let menu: [MenuModel]
    let _id: String
    let date: String
}
