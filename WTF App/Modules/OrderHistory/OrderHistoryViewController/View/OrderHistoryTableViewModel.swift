//
//  OrderHistoryTableViewModel.swift
//  WTF App
//
//  Created by DUCH Chamroeun on 15/10/22.
//

import UIKit

struct OrderHistoryTableViewModel {
    
    private let model: OrderHistoryModel
    
    init(_ model: OrderHistoryModel) {
        self.model = model
    }
}

extension OrderHistoryTableViewModel {
    
    public var textLabelOrderId: String {
        return "Order#: \(model._id)"
    }
    
    public var textLabelTotalPrice: String {
        let totalPrice = model.menu.map({$0.price ?? 0}).reduce(0, +)
        return totalPrice.toPrice
    }
    
    public var textLabelOrderDate: String? {
        
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        let date = dateFormat.date(from: model.date)
        return date?.formatted(date: .complete, time: .standard)
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
                labelMenu.text = "• \(text)"
            }
            labelMenu.font = .systemFont(ofSize: 12)
            labelMenu.textColor = .darkGray
            
            let labelQty = UILabel(frame: .zero)
            labelQty.text = "\(item.count)x"
            labelQty.font = .systemFont(ofSize: 12)
            labelQty.textColor = .darkGray
            
            let stackView = UIStackView(arrangedSubviews: [labelMenu,labelQty])
            stackView.alignment = .fill
            stackView.distribution = .fill
            stackView.spacing = 20
            stackView.axis = .horizontal
            itemViews.append(stackView)
        }
        
        return itemViews
    }
}

