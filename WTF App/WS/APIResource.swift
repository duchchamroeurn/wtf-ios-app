//
//  APIResource.swift
//  iOS Structure
//
//  Created by DUCH Chamroeun on 1/16/20.
//  Copyright © 2020 DUCH Chamroeurn. All rights reserved.
//

import Foundation

enum APIResource<T: Codable> {
    case listCategories
    case listMenus([String:String])
    case menuDetail(String)
    case login(Data)
    case listOrderHistory
    case orderDetail(String)
    case checkout(Data)
    case register(Data)
    
    
}
