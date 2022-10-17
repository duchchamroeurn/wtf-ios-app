//
//  HomeViewController.swift
//  WTF App
//
//  Created by DUCH Chamroeun on 12/10/22.
//

import UIKit

final class HomeViewController: BaseViewController {
    
    override var navigationTitle: String? {
        return "Home"
    }
    
    private let viewModel = HomeViewModel()
    private var cartView: BarItemCartView!

    @IBOutlet private weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        
        setupViewModel()
        
        setupCustomBarButtonItem()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.handleUserCartDidChange(_:)), name: .UserCartDidChange, object: nil)
        
    }
    
    @objc private func handleUserCartDidChange(_ notification: Notification) {
        if let userInfo = notification.object as? [String: Any] {
            let badgeNumber = userInfo["items_badge"] as? String
            cartView.setBadge(value: badgeNumber)
        }
    }
    
    private func setupCustomBarButtonItem() {
        let tapGester = UITapGestureRecognizer(target: self, action: #selector(didTappedCartBarItem(_:)))
        tapGester.numberOfTapsRequired = 1
        
        cartView = BarItemCartView(frame: CGRect(x: 0, y: 0, width: 50.0, height: 50.0))
        cartView.isUserInteractionEnabled = true
        cartView.setBadge(value: UserCartHelper.shared.badgeItem)
        cartView.addGestureRecognizer(tapGester)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: cartView!)
    }
    
    @objc private func didTappedCartBarItem(_ sender: UITapGestureRecognizer) {
        openCartViewController()
    }
    
    private func openCartViewController() {
        let cartViewController = CartViewController.createViewController()
        cartViewController.hidesBottomBarWhenPushed = true
        push(to: cartViewController)
    }
    
    private func showContentViewController(catId: String) {
        
        
        if let viewController = children.first(where: {($0 as? HomeContentViewController)?.id == catId}) {
            view.bringSubviewToFront(viewController.view)
        } else {
            let child = HomeContentViewController.createViewController() as! HomeContentViewController
            child.id = catId
            addChild(child)
            child.view.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(child.view)
            
            
            child.view.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            child.view.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            child.view.topAnchor.constraint(equalTo: collectionView.bottomAnchor).isActive = true
            child.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
            
            child.didMove(toParent: self)
        }
 
        
        
    }
    
    private func setupCollectionView() {
        collectionView.delegate = viewModel
        collectionView.dataSource = viewModel
        collectionView.register(CategoryCollectionViewCell.nibView, forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
    }
    
    private func setupViewModel() {
        
        viewModel.fetchCategories()
        
        viewModel.loadingState.bind { [weak self] state in
            self?.showLoading(state)
        }
        viewModel.selectedCategory.bind { [weak self] catId in
            guard let id = catId else {
                return
            }
            self?.collectionView.reloadData()
            self?.showContentViewController(catId: id)
        }
    }


}
