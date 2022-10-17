//
//  BaseTableViewCell.swift
//  WTF App
//
//  Created by DUCH Chamroeun on 13/10/22.
//

import UIKit

class BaseTableViewCell: UITableViewCell {
    
    public static var nibView: UINib {
        return UINib.init(nibName: "\(self)", bundle: nil)
    }
    
    public static var identifier: String {
        return "\(self)"
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUIComponents()
    }
    
    public func setupUIComponents() {}

}
