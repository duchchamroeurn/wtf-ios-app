//
//  AppAlertDialog.swift
//  WTF App
//
//  Created by DUCH Chamroeun on 17/10/22.
//

import UIKit

enum AlertDialogType {
    case confirmation(AlertDialogData)
    case information(AlertDialogData)
}

struct AlertDialogData {
    let title: String
    let message: String
    let positiveButton: UIAlertAction
}

final class AppAlertDialog: NSObject {
    
    private override init() {}
    
    public static let shared = AppAlertDialog()
    
    public func showDialog(_ type: AlertDialogType, on viewControler: BaseViewController) {
        let alertController = UIAlertController(title: "", message: "", preferredStyle: .alert)
        switch type {
        case .confirmation(let alertDialogData):
            alertController.title = alertDialogData.title
            alertController.message = alertDialogData.message
            alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            alertController.addAction(alertDialogData.positiveButton)
        case .information(let alertDialogData):
            alertController.title = alertDialogData.title
            alertController.message = alertDialogData.message
            alertController.addAction(alertDialogData.positiveButton)
        }
    
        viewControler.present(alertController, animated: true)
        
    }
    
}
