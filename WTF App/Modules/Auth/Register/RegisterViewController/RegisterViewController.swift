//
//  RegisterViewController.swift
//  WTF App
//
//  Created by DUCH Chamroeun on 13/10/22.
//

import UIKit

final class RegisterViewController: BaseViewController {
    
    @IBOutlet private weak var labelCreate: UILabel!
    @IBOutlet private weak var labelAccount: UILabel!
    @IBOutlet private weak var labelDescription: UILabel!
    @IBOutlet private weak var labelAgreeTermPolicy: UILabel!
    @IBOutlet private weak var labelTermPolicy: UILabel!
    
    @IBOutlet private weak var textFieldUserName: UITextField!
    @IBOutlet private weak var textFieldFullName: UITextField!
    @IBOutlet private weak var textFieldDOB: UITextField!
    @IBOutlet private weak var textFieldPassword: UITextField!
    @IBOutlet private weak var textFieldConfirmPassword: UITextField!
    
    @IBOutlet private weak var buttonCreateAccount: UIButton!
    
    private let viewModel = RegisterViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupTextFields()
        
        applyStyleProperties()
        
        setupViewModel()
    }
    
    private func setupTextFields() {
        
        [textFieldUserName,textFieldFullName, textFieldDOB,textFieldPassword,textFieldConfirmPassword].forEach({$0?.delegate = self.viewModel})
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
        
        viewModel.registerError.bind { messageError in
            guard let message = messageError else { return }
            let title = "Register Fail"
            let button = UIAlertAction(title: "OK", style: .cancel)
            
            let dataDialog = AlertDialogData(title: title, message: message, positiveButton: button)
            AppAlertDialog.shared.showDialog(.information(dataDialog), on: self)
        }
    }
    

    private func applyStyleProperties() {
        buttonCreateAccount.layer.cornerRadius = 4.0
    }
    
    private func openDatePickerViewController() {
        let vc = DatePickerViewController.createViewController() as! DatePickerViewController
        vc.delegate = self
        if let date = viewModel.userDateOfBirth {
            vc.selectedDate = date
        }
        vc.modalPresentationStyle = .custom
        let delegate =  TransitioningDelegate(type: .customHeight(height: 350))
        vc.transitioningDelegate = delegate
        present(vc, animated: true)
    }
    
    //MARK: - @IBActions
    
    @IBAction private func buttonCreateAccountTapped(_ sender: UIButton) {
        view.endEditing(true)
        viewModel.register()
    }
    
    @IBAction private func textFieldsDateOfBithTapped(_ sender: UITapGestureRecognizer) {
        openDatePickerViewController()
    }
    
    
}

extension RegisterViewController: DatePickerViewControllerDelegate {
    func didSelectedDate(datePicker: UIDatePicker, date: Date) {
        viewModel.userDateOfBirth = date
        textFieldDOB.text = viewModel.userDateOFBirthFormat
    }
    
    
}


