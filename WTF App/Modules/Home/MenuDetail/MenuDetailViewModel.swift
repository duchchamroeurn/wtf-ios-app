//
//  MenuDetailViewModel.swift
//  WTF App
//
//  Created by DUCH Chamroeun on 13/10/22.
//

import UIKit

final class MenuDetailViewModel: BaseViewModel {
    
    private var model: MenuModel
    
    init(_ model: MenuModel) {
        self.model = model
    }
    
    public func fetchMenuDetail(completion: @escaping (()->Void)) {
        loadingState.value = true
        WSManager.share.request(resource: APIResource<MenuModel>.menuDetail(model._id)) { [weak self] result in
            self?.loadingState.value = false
            switch result {
            case .success(let data):
                self?.model = data
                completion()
            case .failure(let error):
                switch error {
                case .unreachable:
                    self?.errorUnreachable.value = true
                default:
                    print("Error = ", error)
                }
            }
        }
    }

}

extension MenuDetailViewModel {
    
    public var menuName: String {
        return model.name ?? "Detail"
    }
    
    public var placeholderImage: UIImage? {
        return UIImage(named: "SampleMenu")
    }
    
    public var imageURL: URL? {
        let urlString = WebConfig.BASE_URL + (model.image ?? "")
        return URL(string: urlString)
    }
    
    public var priceDisplay: String? {
        return model.price?.toPrice
    }
    
    public var categoryName: String {
        return model.category?.name ?? "N/A"
    }
    
    public var descriptionText: String? {
        return model.description
    }
}


extension MenuDetailViewModel {
    
    public func addToCart() {
        UserCartHelper.shared.add(model)
    }
}
