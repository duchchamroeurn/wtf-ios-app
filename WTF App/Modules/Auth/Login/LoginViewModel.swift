//
//  LoginViewModel.swift
//  WTF App
//
//  Created by DUCH Chamroeun on 15/10/22.
//

import UIKit

final class LoginViewModel: BaseViewModel {
    private var loginDataModel = LoginDataModel()
    
    public var loginError: Observable<String?> = Observable(nil)

}

extension LoginViewModel {
    
    public func login() {
        guard let _ = loginDataModel.username,
              let _ = loginDataModel.password else {
            loginError.value = "Please enter username and password to continue!"
            return
        }
        
        guard let data = try? JSONEncoder().encode(loginDataModel) else {
            loginError.value = "There was something when wrong from encode the user data enter. Please try agian"
            return 
        }
        
        loadingState.value = true
        WSManager.share.request(resource: APIResource<UserModel>.login(data)) { [weak self] result in
            self?.loadingState.value = false
            switch result {
            case .success(let data):
                UserDataHelper.shared.save(data)
            case .failure(let error):
                switch error {
                case .unreachable:
                    self?.errorUnreachable.value = true
                default:
                    self?.loginError.value = "There were incorrect on your input username or password. Please check again."
                }
                
            }
        }
    }
}

extension LoginViewModel: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let tag = textField.tag
        let text = textField.text
        if let typeTextField = LoginTextFieldTag.init(rawValue: tag) {
            switch typeTextField {
            case .userName:
                loginDataModel.username = text
            case .password:
                loginDataModel.password = text
            }
            
        }
    }
    
}
