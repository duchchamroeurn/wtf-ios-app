//
//  BarItemCartView.swift
//  WTF App
//
//  Created by DUCH Chamroeun on 13/10/22.
//

import UIKit

final class BarItemCartView: BaseViewView {
    
    @IBOutlet private weak var imageCart: UIImageView!
    @IBOutlet private weak var labelBadge: UILabel!
    
    override func commonInit() {
        super.commonInit()
        
        labelBadge.clipsToBounds = true
        labelBadge.text = "9"
        labelBadge.layer.cornerRadius = 10.0
    }
    
    public func setBadge(value: String?) {
        labelBadge.isHidden = value == nil
        labelBadge.text = value
    }
}
