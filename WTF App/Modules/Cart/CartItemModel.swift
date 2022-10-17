//
//  CartItemModel.swift
//  WTF App
//
//  Created by DUCH Chamroeun on 14/10/22.
//

import Foundation

struct CartItemModel: Codable {
    let menu: MenuModel
    var qty: Int
}

extension CartItemModel {
    
    public var totalPrice: Double {
        let netPrice = menu.price ?? 0
        return netPrice * Double(qty)
    }
}
