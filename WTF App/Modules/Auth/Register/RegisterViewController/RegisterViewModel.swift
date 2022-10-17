//
//  RegisterViewModel.swift
//  WTF App
//
//  Created by DUCH Chamroeun on 15/10/22.
//

import UIKit

final class RegisterViewModel: BaseViewModel {
    
    private var registerData = RegisterDataBody()
    private var confirmPassword: String? = nil
    
    public var userDateOfBirth: Date? = nil
    public var registerError: Observable<String?> = Observable(nil)

}

extension RegisterViewModel {
    public var userDateOFBirthFormat: String? {
        guard let date = userDateOfBirth else {
            return nil
        }
        
        let dateFormate = DateFormatter()
        dateFormate.dateFormat = "YYYY-MM-dd"
        return dateFormate.string(from: date)
        
    }
    
    public func register() {
        
        registerData.dateOfBirth = userDateOFBirthFormat
        guard let conPassword = confirmPassword,
              registerData.isAllFieldsValid, registerData.isPasswordMatch(conPassword) else {
            registerError.value = "There were errors on any input that you may not enter or mismatch password."
            return
        }
        
        guard let data = try? JSONEncoder().encode(registerData) else {
            registerError.value = "There was something when wrong from encode the user data enter. Please try agian"
            return
        }
        
        loadingState.value = true
        WSManager.share.request(resource: APIResource<UserModel>.register(data)) { result in
            self.loadingState.value = false
            switch result {
            case .success(let data):
                UserDataHelper.shared.save(data)
            case .failure(let error):
                switch error {
                case .unreachable:
                    self.errorUnreachable.value = true
                default:
                    self.registerError.value = "There was something when wrong, Please recheck your data enter and try again."
                }
               
            }
        }
    }
}

extension RegisterViewModel: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let text = textField.text
        let tag = textField.tag
        
        if let typeTextField = RegisterTextFieldTag.init(rawValue: tag) {
            switch typeTextField {
            case .userName:
                registerData.username = text
            case .fullName:
                registerData.fullName = text
            case .password:
                registerData.password = text
            case .confirmPassword:
                confirmPassword = text
            default:
                break
            }
        }
    }

}
