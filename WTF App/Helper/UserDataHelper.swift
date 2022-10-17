//
//  UserDataHelper.swift
//  WTF App
//
//  Created by DUCH Chamroeun on 15/10/22.
//

import UIKit

final class UserDataHelper: NSObject {
    
    public static let shared = UserDataHelper()
    
    private let dataStorage = UserDefaults()
    private let key = "USEDATAKEY"
    
    private override init() {}
    
    private var userData: UserModel? {
        get {
            guard let data = dataStorage.value(forKey: key) as? Data else {
                return nil
            }
            return try? JSONDecoder().decode(UserModel.self, from: data)
        }
        set {
            let data = try? JSONEncoder().encode(newValue)
            dataStorage.set(data, forKey: key)
        }
    }
    
    
    private func pushNotificationAuthChange() {
        NotificationCenter.default.post(name: .UserAuthenticationDidChange, object: ["user_authenticate": userAuthenticated])
    }
    
    public func save(_ user: UserModel) {
        userData = user
        pushNotificationAuthChange()
    }
    
    public func remove() {
        ///clear user cart items
        UserCartHelper.shared.emptyCart(true)
        
        ///remove object from user default
        dataStorage.removeObject(forKey: key)
        dataStorage.synchronize()
        
        pushNotificationAuthChange()
    }

}


extension UserDataHelper {
    
    public var userAuthenticated: Bool {
        return userData != nil
    }
    
    public var userToken: String? {
        return userData?.token
    }
    
    public var fullName: String {
        return userData?.fullName ?? "N/A"
    }
    
    public var userId: String {
        return userData?.userId ?? "N/A"
    }
    
    public var userDateOfBirth: String {
        return userData?.dateOfBirth ?? "N/A"
    }
}
