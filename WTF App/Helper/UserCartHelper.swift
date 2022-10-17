//
//  UserCartHelper.swift
//  WTF App
//
//  Created by DUCH Chamroeun on 14/10/22.
//

import UIKit

final class UserCartHelper: NSObject {
    
    public static var shared = UserCartHelper()
    
    private let dataStorage = UserDefaults()
    private let key = "USERCARTKEY"
    
    private override init() {}
    
    public var badgeItem: String? {
        let number = userCarts.count
        return  number != 0 ? "\(number)" : nil
    }
    
    private var userCarts: [CartItemModel] {
        get {
            if let data = dataStorage.value(forKey: key) as? Data, let items = try? JSONDecoder().decode([CartItemModel].self, from: data) {
                return items
            }
            return []
        }
        set {
            let data = try? JSONEncoder().encode(newValue)
            dataStorage.set(data, forKey: key)
        }
    }
    
    private func pushNotificationDataChange() {
        NotificationCenter.default.post(name: .UserCartDidChange, object: ["items_badge": badgeItem])
    }
    
    
    public func get() -> [CartItemModel] {
        return userCarts
    }
    
    public func add(_ item: MenuModel) {
        var items = get()
        if let index = items.firstIndex(where: {$0.menu._id == item._id}) {
            
            let qty = items[index].qty + 1
            items[index] = CartItemModel(menu: item, qty: qty)
        } else {
            items.append(.init(menu: item, qty: 1))
        }
        userCarts = items
        pushNotificationDataChange()
        
    }
    
    public func update(_ item: CartItemModel) {
        var items = get()
        
        if let index = items.firstIndex(where: {$0.menu._id == item.menu._id}) {
            items[index] = item
            userCarts = items
            pushNotificationDataChange()
        }
    }
    
    public func remove(_ id: String) {
        var items = get()
        
        if let index = items.firstIndex(where: {$0.menu._id == id}) {
            items.remove(at: index)
            userCarts = items
            pushNotificationDataChange()
        }
        
    }
    
    public func emptyCart(_ withoutNotify: Bool = false) {
        userCarts = []
        if !withoutNotify {
            pushNotificationDataChange()
        }
    }

}
