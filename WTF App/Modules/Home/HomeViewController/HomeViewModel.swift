//
//  HomeViewModel.swift
//  WTF App
//
//  Created by DUCH Chamroeun on 12/10/22.
//

import UIKit

final class HomeViewModel: BaseViewModel {
    private var categories = [CategoryModel]()
    public var selectedCategory: Observable<String?> = Observable(nil)
    
    
    public func fetchCategories() {
        loadingState.value = true
        WSManager.share.request(resource: APIResource<[CategoryModel]>.listCategories) { [weak self] result in
    
            self?.loadingState.value = false
            switch result {
            case .success(let data):
                self?.categories = data
                self?.selectedCategory.value = data.first?._id
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

extension HomeViewModel: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let value = categories[indexPath.row].name
        let nsString: NSAttributedString = .init(string: value, attributes: [.font : UIFont.systemFont(ofSize: 16, weight: .semibold)])
        let widthString = nsString.size().width + 16
        let defaultWidth = (collectionView.bounds.width - 32) / 4
        let actualWidth = widthString > defaultWidth ? widthString : defaultWidth
        return .init(width: actualWidth, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as! CategoryCollectionViewCell
        let category = categories[indexPath.row]
        let selected = category._id == selectedCategory.value
        cell.bindData(category.name, selected: selected)

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let category = categories[indexPath.row]
        selectedCategory.value = category._id
    }
    
    
}

