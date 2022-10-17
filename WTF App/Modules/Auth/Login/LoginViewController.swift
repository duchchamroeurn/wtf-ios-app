//
//  LoginViewController.swift
//  WTF App
//
//  Created by DUCH Chamroeun on 13/10/22.
//

import UIKit

final class LoginViewController: BaseViewController {
    
    private let viewModel = LoginViewModel()
    
    @IBOutlet private weak var labelWelcome: UILabel!
    @IBOutlet private weak var labelCompanyName: UILabel!
    @IBOutlet private weak var labelRestaurant: UILabel!
    @IBOutlet private weak var labelCompanyDescription: UILabel!
    
    @IBOutlet private weak var textFieldUserName: UITextField!
    @IBOutlet private weak var textFieldPassword: UITextField!
    
    @IBOutlet private weak var buttonLogin: UIButton!
    @IBOutlet private weak var buttonRegister: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTextFields()
        
        applyStyleProperties()
        
        setupViewModel()
        
    }
    
    private func setupViewModel() {
        viewModel.loadingState.bind { [weak self] status in
            self?.showLoading(status)
        }
        
        viewModel.errorUnreachable.bind { unreachable in
            if unreachable {
                self.showErrorNoInternet()
            }
        }
        
        viewModel.loginError.bind { errorMessage in
            guard let message = errorMessage else { return }
            let title = "Login Fail"
            let button = UIAlertAction(title: "OK", style: .cancel)
            
            let dataDialog = AlertDialogData(title: title, message: message, positiveButton: button)
            AppAlertDialog.shared.showDialog(.information(dataDialog), on: self)
            
        }
    }
    
    private func applyStyleProperties() {
        buttonLogin.layer.cornerRadius = 6.0
    }
    
    private func setupTextFields() {
        textFieldUserName.delegate = viewModel
        textFieldPassword.delegate = viewModel
    }
    
    private func openRegisterScreen() {
        let registerViewController = RegisterViewController.createViewController()
        push(to: registerViewController)
    }
    
    //MARK: - @IBACTIONS
    
    @IBAction private func buttonLoginTapped(_ sender: UIButton) {
        view.endEditing(true)
        viewModel.login()
    }
    
    @IBAction private func buttonRegisterTapped(_ sender: UIButton) {
        view.endEditing(true)
        openRegisterScreen()
    }

    

}
