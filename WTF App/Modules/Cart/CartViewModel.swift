//
//  CartViewModel.swift
//  WTF App
//
//  Created by DUCH Chamroeun on 13/10/22.
//

import UIKit

final class CartViewModel: BaseViewModel {
    
    private var items: [CartItemModel] {
       return  UserCartHelper.shared.get()
    }
    
    public var stateEmptyData: Observable<Bool> = Observable(false)
    
    override init() {
        super.init()
        self.stateEmptyData.value = items.isEmpty
    }
}

extension CartViewModel {
    
    public var textLabelNumberItem: String {
        return "for \(items.count) items"
    }
    
    public var textLabelTotalPrice: String {
        let totalPrice = items.map({$0.totalPrice}).reduce(0, +)
        return totalPrice.toPrice
    }
    
    public var hideViewFooterWrapper: Bool {
        return items.isEmpty
    }
    
    public var hideEmptyBarItem: Bool {
        return hideViewFooterWrapper
    }
    
}

extension CartViewModel {
    
    private func getItems() -> [String] {
        var itemIds = [String]()
        for item in items {
            for _ in 0..<item.qty {
                itemIds.append(item.menu._id)
            }
        }
        
        return itemIds
    }
    
    public func checkout(completion: @escaping (()->Void)) {
        let itemIds = getItems()
        
        guard !itemIds.isEmpty else {
            return
        }
        
        let dicItems = ["items": itemIds]
        
        guard let data = try? JSONSerialization.data(withJSONObject: dicItems) else {
            return
        }
        
        loadingState.value = true
        WSManager.share.request(resource: APIResource<OrderHistoryModel>.checkout(data)) { result in
            self.loadingState.value = false
            switch result {
            case .success:
                completion()
            case .failure(let failure):
                switch failure {
                case .unreachable:
                    self.errorUnreachable.value = true
                default:
                    break
                }
            }
            
        }
    }
}

extension CartViewModel: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CartItemTableViewCell.identifier, for: indexPath) as! CartItemTableViewCell
        let model = items[indexPath.row]
        cell.bindData(model)
        
        return cell
    }
    
}

