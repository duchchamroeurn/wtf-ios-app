//
//  BaseViewController.swift
//  WTF App
//
//  Created by DUCH Chamroeun on 13/10/22.
//

import UIKit

class BaseViewController: UIViewController {
    
    public var navigationTitle: String? {
        return nil
    }
    
    public var backgroundColor: UIColor {
        return .white
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
    }

    
    private func setupUI() {
        navigationItem.title = navigationTitle

        view.backgroundColor = backgroundColor

        
    }
}

extension BaseViewController {
    
    public func showErrorNoInternet() {
        let title = "No Internet Connection"
        let message = "There were seem you lost the internet connection. Please make sure that your Wi-Fi or mobile data is turned on, then try again."
        let button = UIAlertAction(title: "OK", style: .default)
        let dataDialog = AlertDialogData(title: title, message: message, positiveButton: button)
        AppAlertDialog.shared.showDialog(.information(dataDialog), on: self)
    }
    
    public func showEmptyData(with message: String?) {
        let viewController = EmptyDataViewController.createViewController() as! EmptyDataViewController
        viewController.message = message
        addChild(viewController)
        view.addSubview(viewController.view)
        viewController.view.frame = view.bounds
        viewController.willMove(toParent: self)
    }
    
    public final func showLoading(_ value: Bool?) {
        guard let state = value else {
            return
        }
        state ? showLoading() : hideLoading()
    }
    
    private func showLoading() {
        let viewController = LoadingViewController.createViewController()
        addChild(viewController)
        view.addSubview(viewController.view)
        viewController.view.frame = view.bounds
        viewController.willMove(toParent: self)
       
    }
    
     private func hideLoading() {
        let loadingViewController = children.first(where: {$0 is LoadingViewController})
        loadingViewController?.removeFromParent()
        loadingViewController?.view.removeFromSuperview()
        loadingViewController?.willMove(toParent: nil)
    }
    
    public final func push(to viewController: UIViewController, animated: Bool = true) {
        navigationController?.pushViewController(viewController, animated: animated)
    }
}


extension BaseViewController {
    
    public class func createViewController() -> UIViewController {
        let storybord = UIStoryboard(name: "\(self)", bundle: nil)
        return storybord.instantiateViewController(withIdentifier: "\(self)")
    }
}
