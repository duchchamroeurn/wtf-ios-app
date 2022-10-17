//
//  OrderHistoryDetailViewModel.swift
//  WTF App
//
//  Created by DUCH Chamroeun on 15/10/22.
//

import UIKit

final class OrderHistoryDetailViewModel: BaseViewModel {

    private var model: OrderHistoryModel
    
    init(_ model: OrderHistoryModel) {
        self.model = model
    }
}

extension OrderHistoryDetailViewModel {
    
    public func fetchOrderDetail(comletion: @escaping (()->Void)) {
        loadingState.value = true
        WSManager.share.request(resource: APIResource<OrderHistoryModel>.orderDetail(model._id)) { result in
            self.loadingState.value = false
            switch result {
            case .success(let success):
                self.model = success
                comletion()
            case .failure(let failure):
                switch failure {
                case .unreachable:
                    self.errorUnreachable.value = true
                default:
                    print("Error = ", failure)
                }
            }
        }
    }
}

extension OrderHistoryDetailViewModel {
    public var textLabelOrderId: String {
        return "#\(model._id)"
    }
    
    public var textLabelTotalPrice: String {
        let totalPrice = model.menu.map({$0.price ?? 0}).reduce(0, +)
        return totalPrice.toPrice
    }
    
    
    public func createMenuViews() -> [UIView] {
        
        var dicItem: [String: [MenuModel]] = [:]
        
        model.menu.forEach { item in
            if dicItem[item._id] != nil {
                dicItem[item._id]?.append(item)
            } else {
                dicItem[item._id] = [item]
            }
        }
        var itemViews = [UIView]()
        for (_, item) in dicItem {
            let labelMenu = UILabel(frame: .zero)
            if let text = item.first?.name {
                labelMenu.text = "\(text)"
            }
            labelMenu.font = .systemFont(ofSize: 12,weight: .light)
            labelMenu.numberOfLines = 0
            labelMenu.textColor = .darkGray
            
            let labelQty = UILabel(frame: .zero)
            labelQty.text = "\(item.count)"
            labelQty.font = .systemFont(ofSize: 12, weight: .light)
            labelQty.textColor = .darkGray
            
            let labelPrice = UILabel(frame: .zero)
            labelPrice.text = "\(item.first?.price ?? 0)"
            labelPrice.font = .systemFont(ofSize: 12, weight: .light)
            labelPrice.textColor = .darkGray
            
            let amountPrice = item.map({$0.price ?? 0}).reduce(0, +)
            let labelAmountPrice = UILabel(frame: .zero)
            labelAmountPrice.text = "\(amountPrice)"
            labelAmountPrice.font = .systemFont(ofSize: 12, weight: .light)
            labelAmountPrice.textColor = .darkGray
            
            let stackView = UIStackView(arrangedSubviews: [labelMenu,labelQty,labelPrice, labelAmountPrice])
            stackView.alignment = .fill
            stackView.distribution = .fillEqually
            stackView.spacing = 0
            stackView.axis = .horizontal
            itemViews.append(stackView)
        }
        
        return itemViews
    }
}
