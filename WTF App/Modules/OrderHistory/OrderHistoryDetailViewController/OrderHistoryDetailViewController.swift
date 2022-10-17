//
//  OrderHistoryDetailViewController.swift
//  WTF App
//
//  Created by DUCH Chamroeun on 15/10/22.
//

import UIKit

final class OrderHistoryDetailViewController: BaseViewController {
    
    @IBOutlet private weak var labelReferenceNo: UILabel!
    @IBOutlet private weak var labelReferenceNumber: UILabel!
    @IBOutlet private weak var labelTotalPrice: UILabel!
    
    @IBOutlet private weak var stackViewWrapperItem: UIStackView!
    
    public var viewModel: OrderHistoryDetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //setup the view model
        setupViewModel()
        //bindata to view
        bindDataView()
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
        
        viewModel.fetchOrderDetail {
            self.bindDataView()
        }
    }
    
    private func bindDataView() {
        labelReferenceNumber.text = viewModel.textLabelOrderId
        labelTotalPrice.text = viewModel.textLabelTotalPrice
        stackViewWrapperItem.subviews.forEach({$0.removeFromSuperview()})
        let views = viewModel.createMenuViews()
        views.forEach({stackViewWrapperItem.addArrangedSubview($0)})
    }

}
