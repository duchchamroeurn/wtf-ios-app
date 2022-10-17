//
//  NetworkError.swift
//  WTF App
//
//  Created by DUCH Chamroeun on 13/10/22.
//

import Foundation

enum NetworkError: Error {
    case internalError
    case notFound
    case validationError(msg: [String: Any])
    case custom(msg: String)
    case unreachable
    
    var msg: String {
        switch self {
        case .custom(let msg):
            return msg
        default:
            return "Internal Error"
        }
    }
}
