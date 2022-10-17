//
//  MenuTableViewCell.swift
//  WTF App
//
//  Created by DUCH Chamroeun on 12/10/22.
//

import UIKit
import SDWebImage

class MenuTableViewCell: BaseTableViewCell {
    
    private var menuModel: MenuModel?
    
    @IBOutlet private weak var contentMenuView: UIView!
    @IBOutlet private weak var imageMenu: UIImageView!
    
    @IBOutlet private weak var labelMenuCategory: UILabel!
    @IBOutlet private weak var labelMenuName: UILabel!
    @IBOutlet private weak var labelMenuPrice: UILabel!
    
    @IBOutlet private weak var buttonAddCart: UIButton!
    
    override func setupUIComponents() {
        super.setupUIComponents()
        applyStyleViews()
    }
    
    private func applyStyleViews() {
        
        contentMenuView.backgroundColor = .white
        
        imageMenu.layer.cornerRadius = 6.0
        imageMenu.layer.borderWidth = 1.0
        imageMenu.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    public func bindData(_ model: MenuModel) {
        menuModel = model
        labelMenuName.text = model.name
        labelMenuPrice.text = model.price?.toPrice
        labelMenuCategory.text = model.category?.name
        let stringURL = WebConfig.BASE_URL + (model.image ?? "")
        imageMenu.sd_setImage(with: URL(string: stringURL), placeholderImage: UIImage(named: "SampleMenu"))
    }

    
    @IBAction private func buttonAddToCartTapped(_ sender: UIButton) {

        if let model = menuModel {
            UserCartHelper.shared.add(model)
        }
    }
    
    
}
