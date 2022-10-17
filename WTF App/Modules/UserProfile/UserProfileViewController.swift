//
//  UserProfileViewController.swift
//  WTF App
//
//  Created by DUCH Chamroeun on 12/10/22.
//

import UIKit

final class UserProfileViewController: BaseViewController {
    
    override var navigationTitle: String? {
        return "Profile"
    }
    
    @IBOutlet private weak var imageUserProfile: UIImageView!
    
    @IBOutlet private weak var labelUserName: UILabel!
    @IBOutlet private weak var labelDOB: UILabel!
    @IBOutlet private weak var labelPhoneNumber: UILabel!
    @IBOutlet private weak var labelUserId: UILabel!
    @IBOutlet private weak var labelUserEmail: UILabel!
    
    @IBOutlet private weak var viewWrapperId: UIView!
    @IBOutlet private weak var viewWrapperEmail: UIView!
    @IBOutlet private weak var viewWrapperPhone: UIView!
    
    @IBOutlet private weak var buttonSignOut: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        applyStyleProperties()
        
        bindViewData()
        
    }
    
    private func bindViewData() {
        let model = UserDataHelper.shared
        labelUserName.text = model.fullName
        labelDOB.text = model.userDateOfBirth
        labelUserId.text = model.userId
        labelUserEmail.text = model.fullName
        labelPhoneNumber.text = "N/A"
        
        
    }
    
    private func applyStyleProperties() {
        
        imageUserProfile.layer.cornerRadius = 50.0
        imageUserProfile.layer.borderColor = UIColor.gray.cgColor
        imageUserProfile.layer.borderWidth = 1.0
        [viewWrapperId,viewWrapperEmail,viewWrapperPhone,buttonSignOut].forEach { view in
            view?.layer.cornerRadius = 4.0
        }
    }
    
    //MARK: - @IBActions
    
    @IBAction private func buttonSignOutTapped(_ sender: UIButton) {
        let title = "Sign Out"
        let message = "Singing out will clear all your cart menu shoping. Do you want to sign out?"
        let button = UIAlertAction(title: "Sign Out", style: .destructive) { _ in
            UserDataHelper.shared.remove()
        }
        let dataDialog = AlertDialogData(title: title, message: message, positiveButton: button)
        AppAlertDialog.shared.showDialog(.confirmation(dataDialog), on: self)
    }
    
}
