//
//  TargetResource.swift
//  Z1
//
//  Created by DUCH Chamroeun on 3/2/20.
//  Copyright © 2020 Gaeasys. All rights reserved.
//

import Foundation

protocol TargetResource {
    /// The target's base `URL`.
    var baseURL: URL { get }
    
    var prefix: String? { get }
    
    /// The path to be appended to `baseURL` to form the full `URL`.
    var path: String { get }
    
    /// The HTTP method used in the request.
    var method: HttpMethod { get }
    
    /// The request body
    var body: Data? { get }
    
    /// The api version as path
    var version: String { get }
    
    /// The query params for request
    var params: [String: String]? { get }
    
    /// The type of request for authorization type
    var authorizeType: AuthorizationType { get }
    
    /// The request header
    var  header: [String: String] { get }
}
