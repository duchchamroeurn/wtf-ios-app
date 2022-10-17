//
//  MenuDetailViewController.swift
//  WTF App
//
//  Created by DUCH Chamroeun on 13/10/22.
//

import UIKit
import SDWebImage

final class MenuDetailViewController: BaseViewController {
    
    @IBOutlet private weak var imageMenu: UIImageView!
    
    @IBOutlet private weak var labelMenuName: UILabel!
    @IBOutlet private weak var labelMenuCategory: UILabel!
    @IBOutlet private weak var labelPrice: UILabel!
    @IBOutlet private weak var labelDescription: UILabel!
    
    @IBOutlet private weak var buttonAddToCart: UIButton!
    
    public var viewModel: MenuDetailViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        buttonAddToCart.layer.cornerRadius = 4.0
        
        setupData()
        ///handle loading state
        viewModel.loadingState.bind { [weak self] state in
            self?.showLoading(state)
        }
        ///fetching data
        viewModel.fetchMenuDetail {
            self.setupData()
        }
    }
    
    
    private func setupData() {
        imageMenu.sd_setImage(with: viewModel.imageURL, placeholderImage: viewModel.placeholderImage)
        labelMenuName.text = viewModel.menuName
        labelMenuCategory.text = viewModel.categoryName
        labelPrice.text = viewModel.priceDisplay
        labelDescription.text = viewModel.descriptionText
    }

    @IBAction private func buttonAddToCartTapped(_ sender: UIButton) {
        viewModel.addToCart()
        navigationController?.popViewController(animated: true)
    }
}
