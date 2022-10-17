//
//  LoadingViewController.swift
//  WTF App
//
//  Created by DUCH Chamroeun on 13/10/22.
//

import UIKit

final class LoadingViewController: BaseViewController {
    
    override var backgroundColor: UIColor {
        return UIColor.black.withAlphaComponent(0.2)
    }

    @IBOutlet private weak var boxView: UIView!
    @IBOutlet private weak var loadingView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        boxView.layer.cornerRadius = 6.0
        boxView.layer.borderWidth = 0.5
        boxView.layer.borderColor = UIColor.lightGray.cgColor
        boxView.layer.shadowColor = UIColor.black.cgColor
        boxView.layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
        boxView.layer.shadowOpacity = 0.1
        
        loadingView.startAnimating()
    }

}
