//
//  WebConfig.swift
//  Z1
//
//  Created by DUCH Chamroeun on 3/2/20.
//  Copyright © 2020 Gaeasys. All rights reserved.
//

import Foundation

struct WebConfig {
    
    public static var BASE_URL: String {
        get {
            switch WSManager.share.env {
            
            case .dev:
                return "http://157.230.245.180:3001/"
            case .pro:
                return "http://157.230.245.180:3001/"
            }
            
        }
    }
    
}
