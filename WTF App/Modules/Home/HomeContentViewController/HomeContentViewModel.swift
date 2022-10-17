//
//  HomeContentViewModel.swift
//  WTF App
//
//  Created by DUCH Chamroeun on 13/10/22.
//

import UIKit

final class HomeContentViewModel: BaseViewModel {
    
    private var menus = [MenuModel]()
    
    public var didSelectedMenu: Observable<MenuModel?> = Observable(nil)
    
    
    public func fetchMenus(categoryId: String, completion: @escaping (()->Void)) {
        loadingState.value = true
        let param = ["catId": categoryId]
        WSManager.share.request(resource: APIResource<[MenuModel]>.listMenus(param)) { [weak self] result in
            self?.loadingState.value = false
            switch result {
               
            case .success(let data):
                self?.menus = data
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

extension HomeContentViewModel: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menus.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 240.00
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MenuTableViewCell.identifier, for: indexPath) as! MenuTableViewCell
        let menu = menus[indexPath.row]
        cell.bindData(menu)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let menu = menus[indexPath.row]
        didSelectedMenu.value = menu
    }
    
}
