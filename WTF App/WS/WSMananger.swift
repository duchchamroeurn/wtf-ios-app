//
//  WSMananger.swift
//  iOS Structure
//
//  Created by DUCH Chamroeun on 1/16/20.
//  Copyright © 2020 DUCH Chamroeurn. All rights reserved.
//

import Foundation
import Reachability

final class WSManager: NSObject {
    
    /// Instant object WSManager
    public static var share: WSManager {
        return WSManager()
    }
    
    /// Enviroment of Web Service access
    //TODO: - Must be update base on the environment
    public let env: ENV = .pro
    
    public var isConnected: Bool {
        return reachability.connection != .unavailable
    }
    
    private var reachability: Reachability!
    
    //MARK:- Initialize
    private override init() {
        super.init()
        reachability = try! Reachability()
    }
    
    /// To request the resource from the network
    ///
    /// - Parameters:
    ///   - resource: data resource
    ///   - completion: completion tasks handle
    public func request<T>(resource: APIResource<T>, completion: @escaping (Result<T, NetworkError>)->()) {
        
        if !isConnected {
            DispatchQueue.main.async {
                completion(.failure(.unreachable))
            }
            return
        }
        buildURLRequest(resource) { (req) in
            guard let request = req else {
                DispatchQueue.main.async {
                    completion(.failure(.internalError))
                }
                return
            }
            
            let session = URLSession.shared
            
            session.dataTask(with: request) { (data, response, error) in
                
                guard let data = data, error == nil else {
                    DispatchQueue.main.async {
                        completion(.failure(.internalError))
                    }
                    return
                }
                if let httpResponse = response as? HTTPURLResponse{
                    if let responseType = httpResponse.status?.responseType {
                        switch responseType {
                        case .success:
                            do {
                                let result = try JSONDecoder().decode(T.self, from: data)
                                DispatchQueue.main.async {
                                    completion(.success(result))
                                }
                            } catch let error {
                                print("String Data = ", String.init(data: data, encoding: .utf8) ?? "")
                                print("===DecodeError==== CodingPath:", error)
                                DispatchQueue.main.async {
                                    completion(.failure(.internalError))
                                }
                            }
                        case .clientError:
                            if httpResponse.status! == .notFound {
                                    DispatchQueue.main.async {
                                        completion(.failure(.notFound))
                                    }
                    
                                return
                            }
                            
                            if httpResponse.status! == .unprocessableEntity {
                                do {
                                    let responseData = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any]
                                    if let errors = responseData?["errors"] as? [String: Any] {
                                        DispatchQueue.main.async {
                                            completion(.failure(.validationError(msg: errors)))
                                        }
                                    }
                                } catch {
                                    DispatchQueue.main.async {
                                        completion(.failure(.internalError))
                                    }
                                }
                                return
                            }
                            
                            do {
                                let responseData = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any]
                                if let message = responseData?["message"] as? String {
                                    DispatchQueue.main.async {
                                        completion(.failure(.custom(msg: message)))
                                    }
                                    return
                                }
                            } catch let error {
                                print("Client Error = ", error)
                                print("\n\n===========Error===========")
                                if let str = String(data: data, encoding: String.Encoding.utf8){
                                    print("Print Server data:- " + str)
                                }
                                print("===========================\n\n")
                                
                                DispatchQueue.main.async {
                                    completion(.failure(.internalError))
                                }
                            }
                        case .serverError:
                            print("\n\n===========Server Error===========")
                            if let str = String(data: data, encoding: String.Encoding.utf8){
                                print("Print Server data:- " + str)
                            }
                            print("===========================\n\n")
                            DispatchQueue.main.async {
                                completion(.failure(.internalError))
                                
                            }
                        case .undefined, .redirection, .informational:
                            DispatchQueue.main.async {
                                completion(.failure(.internalError))
                                
                            }
                        }
                    }
                }
            }.resume()
        }
    }
    
    private func buildURLRequest<T>(_ resource: APIResource<T>, completion: @escaping (URLRequest?) ->Void) {
        var url = resource.baseURL
        if let prefix = resource.prefix {
            url.appendPathComponent(prefix)
        }
        url.appendPathComponent(resource.version)
        url.appendPathComponent(resource.path)
        
        if let params = resource.params {
            
            guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
                completion(nil)
                return
            }
            
            var queryItems = [URLQueryItem]()
            for (key, value) in params {
                queryItems.append(URLQueryItem(name: key, value: value))
            }
    
            urlComponents.queryItems = queryItems
            guard let fullURL = urlComponents.url else {
                completion(nil)
                return
            }
            url = fullURL
        }
        
        print("URL Request = ", url)
        var request = URLRequest(url: url)
        request.httpMethod = resource.method.rawValue
        request.httpBody = resource.body
        if let body = resource.body {
            print("Body Request", String.init(data: body, encoding: .utf8) ?? "")
        }
        for (key, value) in resource.header {
            request.addValue(value, forHTTPHeaderField: key)
        }
        
        switch resource.authorizeType {
        case .bearer:
            if let token = UserDataHelper.shared.userToken {
                let barear_token = "Bearer \(token)"
                print("Access Token 1 = ", barear_token)
                request.addValue(barear_token, forHTTPHeaderField: "Authorization")
            }
        default:
            break
        }
        
        completion(request)
    }
    
}
