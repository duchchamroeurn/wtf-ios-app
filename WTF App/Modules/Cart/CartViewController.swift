//
//  CartViewController.swift
//  WTF App
//
//  Created by DUCH Chamroeun on 13/10/22.
//

import UIKit

final class CartViewController: BaseViewController {
    
    override var navigationTitle: String? {
        return "Cart"
    }
    
    private let viewModel = CartViewModel()

    @IBOutlet private weak var tableView: UITableView!
    
    @IBOutlet private weak var viewFooterWrapper: UIView!
    
    @IBOutlet private weak var labelTotal: UILabel!
    @IBOutlet private weak var lblNumberItem: UILabel!
    @IBOutlet private weak var labelTotalPrice: UILabel!
    
    @IBOutlet private weak var buttonCheckout: UIButton!
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .UserCartDidChange, object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        applyStyleProperties()
        
        setupTableView()
        
        bindViewData()
       
        bindViewRightNavigationBarItem()
        
        setupNotificationObserver()
        
        setupViewModel()
    }
    
    private func setupViewModel() {
        viewModel.loadingState.bind { [weak self] status in
            self?.showLoading(status)
        }
        
        viewModel.errorUnreachable.bind { unreachable in
            if unreachable {
                self.showErrorNoInternet()
            }
        }
        
        viewModel.stateEmptyData.bind { empty in
            if empty {
                self.showEmptyData(with: "Your cart is currently empty. To process your checkout , you must add some menus to your shopping cart.")
            }
        }
    }
    
    @IBAction private func buttonCheckoutTapped(_ sender: UIButton) {
        
        viewModel.checkout {
            ///refresh the data order history
            ///
            NotificationCenter.default.post(name: .UserOrderDataHistoryChange, object: nil)
            
            UserCartHelper.shared.emptyCart()
            
            let title = "You've successfully placed the order"
            let message = "You can check and view detail of your order on the Order History. Thanks"
            let button = UIAlertAction(title: "OK", style: .default) { _ in
                self.navigationController?.popToRootViewController(animated: true)
            }
            let dataDialog = AlertDialogData(title: title, message: message, positiveButton: button)
            AppAlertDialog.shared.showDialog(.information(dataDialog), on: self)

        }
    }
    
    
    @objc private func handleUserCartDidChange(_ notification: Notification) {
        bindViewData()
        bindViewRightNavigationBarItem()
        viewModel.stateEmptyData.value = viewModel.hideViewFooterWrapper
        tableView.reloadData()
    }
    
    @objc private func emptyCart(_ sender: UIBarButtonItem) {
        let title = "Empty Cart"
        let message = "Your menus will be removed from your cart shoping. Are you sure?"
        let button = UIAlertAction(title: "Empty", style: .destructive) { _ in
            UserCartHelper.shared.emptyCart()
        }
        let dataDialog = AlertDialogData(title: title, message: message, positiveButton: button)
        AppAlertDialog.shared.showDialog(.confirmation(dataDialog), on: self)
        
    }
    
    private func setupNotificationObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.handleUserCartDidChange(_:)), name: .UserCartDidChange, object: nil)
    }
    
    private func bindViewRightNavigationBarItem() {
        if viewModel.hideEmptyBarItem {
            navigationItem.rightBarButtonItem = nil
        } else {
            let trashBarItem = UIBarButtonItem(image:  UIImage(systemName: "trash.fill"), style: .done, target: self, action: #selector(self.emptyCart(_:)))
            trashBarItem.tintColor = .red
            navigationItem.rightBarButtonItem = trashBarItem
        }
    }
    
    
    private func applyStyleProperties() {
        buttonCheckout.layer.cornerRadius = 4.0
    }
    
    private func bindViewData() {
        lblNumberItem.text = viewModel.textLabelNumberItem
        labelTotalPrice.text = viewModel.textLabelTotalPrice
        viewFooterWrapper.isHidden = viewModel.hideViewFooterWrapper
    }
    
    private func setupTableView() {
        tableView.delegate = viewModel
        tableView.dataSource = viewModel
        tableView.register(CartItemTableViewCell.nibView, forCellReuseIdentifier: CartItemTableViewCell.identifier)
    }
    
    

}
