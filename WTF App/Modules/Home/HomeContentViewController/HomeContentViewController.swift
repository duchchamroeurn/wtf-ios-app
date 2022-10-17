//
//  HomeContentViewController.swift
//  WTF App
//
//  Created by DUCH Chamroeun on 12/10/22.
//

import UIKit

final class HomeContentViewController: BaseViewController {
    
    private let viewModel = HomeContentViewModel()
    public var id: String!
    
    private let pullRefresh = UIRefreshControl()
    
    @IBOutlet private weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupViewModel()
    }
    
    private func setupTableView() {
        pullRefresh.addTarget(self, action: #selector(self.pullRefreshDidChanged(_:)), for: .valueChanged)
        tableView.refreshControl = pullRefresh
        tableView.delegate = viewModel
        tableView.dataSource = viewModel
        tableView.register(MenuTableViewCell.nibView, forCellReuseIdentifier: MenuTableViewCell.identifier)
    }
    
    private func fetchingData() {
        viewModel.fetchMenus(categoryId: id, completion: { [weak self] in
            self?.tableView.reloadData()
            self?.pullRefresh.endRefreshing()
        })
    }
    
    private func setupViewModel() {
        fetchingData()
        
        viewModel.loadingState.bind { [weak self] state in
            self?.showLoading(state)
        }
        
        viewModel.errorUnreachable.bind { unreachable in
            if unreachable {
                self.showErrorNoInternet()
            }
        }
        
        viewModel.didSelectedMenu.bind { [weak self] model in
            
            self?.openMenuDetail(model)
        }
    }
    
    @objc private func pullRefreshDidChanged(_ sender: UIRefreshControl) {
        fetchingData()
    }
    
    private func openMenuDetail(_ model: MenuModel?) {
        guard let menu = model else { return }
        let menuDetailViewController = MenuDetailViewController.createViewController() as! MenuDetailViewController
        menuDetailViewController.hidesBottomBarWhenPushed = true
        menuDetailViewController.viewModel = .init(menu)
        
        push(to: menuDetailViewController)
    }
    
}
