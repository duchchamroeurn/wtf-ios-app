//
//  OrderHistoryViewController.swift
//  WTF App
//
//  Created by DUCH Chamroeun on 12/10/22.
//

import UIKit

final class OrderHistoryViewController: BaseViewController {
    
    override var navigationTitle: String? {
        return "History"
    }
    
    private let viewModel = OrderHistoryViewModel()
    
    @IBOutlet private weak var tableView: UITableView!
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .UserOrderDataHistoryChange, object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupTableView()
        setupViewModel()
        
        setupNotificationObserver()
    }
    
    private func setupNotificationObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.handleNotificationPushDataChange(_:)), name: .UserOrderDataHistoryChange, object: nil)
    }
    
    @objc private func handleNotificationPushDataChange(_ sender: Notification) {
        fetchData()
    }
    
    private func fetchData() {
        viewModel.fetchOrderHistory {
            self.tableView.reloadData()
        }
    }
    
    private func setupViewModel() {
        
        fetchData()
        
        viewModel.loadingState.bind { [weak self] status in
            self?.showLoading(status)
        }
    
        viewModel.didSelectedItem.bind { item in
            self.openOrderDetail(item)
        }
        
        viewModel.stateEmptyHistory.bind { empty in
            guard let emptyData = empty, emptyData else {
                return
            }
            
            self.showEmptyData(with: "Your order history is empty.")
        }
        
        viewModel.errorUnreachable.bind { unreachable in
            if unreachable {
                self.showErrorNoInternet()
            }
        }
    }
    
    private func openOrderDetail(_ model: OrderHistoryModel?) {
        guard let item = model else {
            return
        }
        
        let orderDetailViewController = OrderHistoryDetailViewController.createViewController() as! OrderHistoryDetailViewController
        orderDetailViewController.viewModel = .init(item)
        orderDetailViewController.hidesBottomBarWhenPushed = true
        push(to: orderDetailViewController)
        
    }
    
    private func setupTableView() {
        tableView.delegate = viewModel
        tableView.dataSource = viewModel
        tableView.register(OrderHistoryTableViewCell.nibView, forCellReuseIdentifier: OrderHistoryTableViewCell.identifier)
    }
}
