//
//  ViewController.swift
//  WTF App
//
//  Created by DUCH Chamroeun on 12/10/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let loadingView = UIActivityIndicatorView(style: .medium)

        view.backgroundColor = .red
        loadingView.center = view.center
        view.addSubview(loadingView)
        loadingView.startAnimating()
    }


}

