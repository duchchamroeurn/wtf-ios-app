//
//  CategoryCollectionViewCell.swift
//  WTF App
//
//  Created by DUCH Chamroeun on 12/10/22.
//

import UIKit

final class CategoryCollectionViewCell: BaseCollectionViewCell {

    @IBOutlet private weak var viewWrapper: UIView!
    @IBOutlet private weak var labelTextDisplay: UILabel!

    override func setupUIComponents() {
        super.setupUIComponents()
        applyStyleViewWraper()
    }
    
    private func applyStyleViewWraper() {
        viewWrapper.layer.cornerRadius = 6.0
        viewWrapper.layer.borderWidth = 1.0
        viewWrapper.layer.borderColor = UIColor.gray.cgColor
        labelTextDisplay.font = UIFont.systemFont(ofSize: 16, weight: .regular)
    }
    
    public func bindData(_ text: String?, selected: Bool) {
        labelTextDisplay.text = text
        let color: UIColor = selected ? .systemGray5 : .white
        let borderColor: UIColor = selected ? .gray : .lightGray
        let font: UIFont = selected ? .systemFont(ofSize: 16, weight: .semibold) : .systemFont(ofSize: 16, weight: .regular)
        viewWrapper.backgroundColor = color
        viewWrapper.layer.borderColor = borderColor.cgColor
        labelTextDisplay.font = font
    }

}
