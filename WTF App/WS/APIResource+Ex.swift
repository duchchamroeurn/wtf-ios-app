//
//  APIResource+Ex.swift
//  Z1
//
//  Created by DUCH Chamroeun on 3/2/20.
//  Copyright © 2020 Gaeasys. All rights reserved.
//

import Foundation

extension APIResource: TargetResource {
    
    var baseURL: URL {
        switch self {
        default:
            guard let url = URL.init(string: WebConfig.BASE_URL) else { fatalError("Invalid Base URL.") }
            return url
        }
    }
    
    var prefix: String? {
        switch self {
        default:
            return ""
        }
    }
    
    var path: String {
        switch self {
        case .listCategories:
            return "categories"
        case .listMenus:
            return "menus"
        case .menuDetail(let id):
            return "menu/\(id)"
        case .login:
            return "login"
        case .listOrderHistory,
                .checkout:
            return "orders"
        case .orderDetail(let id):
            return "order/\(id)"
        case .register:
            return "register"
        }
    }
    
    var method: HttpMethod {
        switch self {
        case .login,
                .checkout,
                .register:
            return .POST
        default:
            return .GET
        }
    }
    
    var body: Data? {
        switch self {
        case .login(let data):
            return data
        case .checkout(let data):
            return data
        case .register(let data):
            return data
        default:
            return nil
        }
    }
    
    var version: String {
        switch self {
        default:
            return ""
        }
    }
    
    var params: [String : String]? {
        switch self {
        case .listMenus(let params):
            return params
        default:
            return nil
        }
    }
    
    var authorizeType: AuthorizationType {
        switch self {
        case .listOrderHistory,
                .orderDetail,
                .checkout:
            return .bearer
        default:
            return .none
        }
    }
    
    var header: [String : String] {
        switch self {
        default:
            return [
                "Content-Type": "application/json",
                "Accept": "application/json",
            ]
        }
    }
    
    
}
