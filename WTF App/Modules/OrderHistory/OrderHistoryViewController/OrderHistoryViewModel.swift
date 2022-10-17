//
//  OrderHistoryViewModel.swift
//  WTF App
//
//  Created by DUCH Chamroeun on 13/10/22.
//

import UIKit

final class OrderHistoryViewModel: BaseViewModel {
    
    private var orderHistories = [OrderHistoryModel]()
    
    public var didSelectedItem: Observable<OrderHistoryModel?> = Observable(nil)
    public var stateEmptyHistory: Observable<Bool?> = Observable(nil)

}

extension OrderHistoryViewModel {
    
    public func fetchOrderHistory(completion: @escaping (()->Void)) {
        loadingState.value = true
        WSManager.share.request(resource: APIResource<[OrderHistoryModel]>.listOrderHistory) { [weak self] result in
            self?.loadingState.value = false
            switch result {
            case .success(let success):
                self?.orderHistories = success
                self?.stateEmptyHistory.value = success.isEmpty
                completion()
            case .failure(let failure):
                switch failure {
                case .unreachable:
                    self?.errorUnreachable.value = true
                default:
                    print("Error = ", failure)
                }
            }
        }
    }
}

extension OrderHistoryViewModel: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderHistories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OrderHistoryTableViewCell.identifier, for: indexPath) as! OrderHistoryTableViewCell
        let model = orderHistories[indexPath.row]
        cell.bindData(model) { item in
            self.didSelectedItem.value = item
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
}


