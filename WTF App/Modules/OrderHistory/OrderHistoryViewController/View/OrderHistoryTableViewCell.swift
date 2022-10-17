//
//  OrderHistoryTableViewCell.swift
//  WTF App
//
//  Created by DUCH Chamroeun on 12/10/22.
//

import UIKit

final class OrderHistoryTableViewCell: BaseTableViewCell {
    
    private var onViewDetailTapped: ((OrderHistoryModel)->Void)?
    private var model: OrderHistoryModel?
    
    @IBOutlet weak var labelOrderId: UILabel!
    @IBOutlet weak var labelTotalPrice: UILabel!
    @IBOutlet weak var labelOrderDate: UILabel!
    
    @IBOutlet weak var stackViewItem: UIStackView!
    
    
    public func bindData(_ model: OrderHistoryModel, didSelected: @escaping (OrderHistoryModel)->Void) {
        self.model = model
        let viewModel = OrderHistoryTableViewModel(model)
        onViewDetailTapped = didSelected
        labelOrderId.text = viewModel.textLabelOrderId
        labelTotalPrice.text = viewModel.textLabelTotalPrice
        labelOrderDate.text = viewModel.textLabelOrderDate
        stackViewItem.subviews.forEach({$0.removeFromSuperview()})
        let views = viewModel.createMenuViews()
        views.forEach({stackViewItem.addArrangedSubview($0)})
        
    }
    
    @IBAction private func buttonViewDetailTapped(_ sender: UIButton) {
        guard let item = model else {
            return
        }
        onViewDetailTapped?(item)
    }
    
}
