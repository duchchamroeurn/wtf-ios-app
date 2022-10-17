//
//  CartItemTableViewCell.swift
//  WTF App
//
//  Created by DUCH Chamroeun on 13/10/22.
//

import UIKit

final class CartItemTableViewCell: BaseTableViewCell {
    
    private var cartItemModel: CartItemModel?
    
    @IBOutlet private weak var cartContentView: UIView!
    
    @IBOutlet private weak var menuImageView: UIImageView!
    
    @IBOutlet private weak var labelMenuName: UILabel!
    @IBOutlet private weak var labelMenuCategory: UILabel!
    @IBOutlet private weak var labelMenuPrice: UILabel!
    @IBOutlet private weak var labelMenuQty: UILabel!
    
    @IBOutlet private weak var buttonDecreaseQty: UIButton!
    @IBOutlet private weak var buttonIncreaseQty: UIButton!
    @IBOutlet private weak var buttonRemoveMenu: UIButton!

    
    override func setupUIComponents() {
        super.setupUIComponents()
        
       applyStyleProperties()
    }
    
    private func applyStyleProperties() {
        cartContentView.layer.cornerRadius = 4.0
        menuImageView.layer.cornerRadius = 4.0
    }
    
    
    public func bindData(_ model: CartItemModel) {
        cartItemModel = model
        let menuModel = model.menu
        labelMenuName.text = menuModel.name
        labelMenuPrice.text = menuModel.price?.toPrice
        labelMenuCategory.text = menuModel.category?.name
        labelMenuQty.text = "\(model.qty) QTY"
        
        let stringURL = WebConfig.BASE_URL + (menuModel.image ?? "")
        menuImageView.sd_setImage(with: URL(string: stringURL), placeholderImage: UIImage(named: "SampleMenu"))
    }
    
    //MARK: - @IBActions
    
    @IBAction private func buttonDecreaseTapped(_ sender: UIButton) {
        if var model = cartItemModel, model.qty > 1 {
            model.qty -= 1
            UserCartHelper.shared.update(model)
        }
       
    }
    
    @IBAction private func buttonIncreaseTapped(_ sender: UIButton) {
        if var model = cartItemModel {
            model.qty += 1
            UserCartHelper.shared.update(model)
        }
    }
    
    @IBAction private func buttonRemoveMenuTapped(_ sender: UIButton) {
        if let id = cartItemModel?.menu._id {
            UserCartHelper.shared.remove(id)
        }
    }
    
}
