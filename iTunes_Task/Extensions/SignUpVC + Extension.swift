import Foundation
import UIKit

extension SignUpViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        switch textField {
        case firstNameTextField: setTextField(textField: firstNameTextField,
                                              label: firstNameLabel,
                                              validType: nameValueType,
                                              validMessage: "Name is valid",
                                              wrongMessage: "Only A-Z characters",
                                              string: string,
                                              range: range)
        case secondNameTextField: setTextField(textField: secondNameTextField,
                                              label: secondNameLabel,
                                              validType: nameValueType,
                                              validMessage: "Name is valid",
                                              wrongMessage: "Only A-Z characters",
                                              string: string,
                                              range: range)
        case emailTextField: setTextField(textField: emailTextField,
                                              label: emailLabel,
                                              validType: emailValueType,
                                              validMessage: "Email is valid",
                                              wrongMessage: "Email is not valid",
                                              string: string,
                                              range: range)
        case passwordTextField: setTextField(textField: passwordTextField,
                                              label: passwordLabel,
                                              validType: passwoftValueType,
                                              validMessage: "Password is valid",
                                              wrongMessage: "Password is not valid",
                                              string: string,
                                              range: range)
        case phoneNumberTextField: phoneNumberTextField.text = setPhoneNumberMask(phoneNumberTextField,
                                                                                  mask: "+A (AAA) AAA-AA-AA",
                                                                                  string: string,
                                                                                  range: range)
        default: break
        }
        
        return false
    }
    
    func textFieldReturn(_ textField: UITextField) -> Bool {
        firstNameTextField.resignFirstResponder()
        secondNameTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        
        return true
    }
}

extension SignUpViewController {
    
    func setupConstraints() {
        
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        backgroundView.snp.makeConstraints {
            $0.centerX.centerY.equalTo(scrollView)
            $0.height.width.equalToSuperview()
        }
        
        stackView.snp.makeConstraints {
            $0.centerY.centerX.equalTo(backgroundView)
            $0.leading.equalTo(backgroundView).inset(20)
            $0.trailing.equalTo(backgroundView).offset(-20)
        }
        
        loginLabel.snp.makeConstraints {
            $0.centerX.equalTo(backgroundView)
            $0.bottom.equalTo(stackView.snp.top).offset(-30)
        }
        
        signUpButton.snp.makeConstraints {
            $0.centerX.equalTo(backgroundView)
            $0.top.equalTo(stackView.snp.bottom).offset(30)
            $0.width.equalTo(300)
            $0.height.equalTo(40)
        }
    }
}

extension SignUpViewController {
    
    func keyboardNotification() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    func removeKeyboardNotification() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(notification: Notification) {
        let userInfo = notification.userInfo
        let heigtKeyboard = (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        scrollView.contentOffset = CGPoint(x: 0, y: heigtKeyboard.height / 2)
        
        
    }
    
    @objc private func keyboardWillHide(notification: Notification) {
        scrollView.contentOffset = CGPoint.zero
    }
}

extension SignUpViewController {
    
    func setTextField(textField: UITextField, label: UILabel, validType: String.ValidTypes, validMessage: String, wrongMessage: String, string: String, range: NSRange) {
       
        let text = (textField.text ?? "") + string
        let result: String
        
        if range.length == 1 {
            let end = text.index(text.startIndex, offsetBy: text.count - 1)
            result = String(text[text.startIndex..<end])
        } else {
            result = text
        }
        
        textField.text = result
        
        if result.isValid(validType) {
            label.text = validMessage
        } else {
            label.text = wrongMessage
        }
    }
    
    func setPhoneNumberMask(_ textField: UITextField, mask: String, string: String, range: NSRange) -> String{
        
        let text = textField.text ?? ""
        
        let phone = (text as NSString).replacingCharacters(in: range, with: string)
        let number = phone.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result = ""
        var index = number.startIndex
        
        for character in mask where index < number.endIndex {
            if character == "A" {
                result.append(number[index])
                index = number.index(after: index)
            } else {
                result.append(character)
            }
        }
        
        if result.count == 18 {
            phoneNumberLabel.text = "Phone is valid"
        } else {
            phoneNumberLabel.text = "Phone is not valid"
        }
        
        return result
    }
    
    func ageIsValid() -> Bool {
        let calendar = NSCalendar.current
        let dateNoew = Date()
        let birthday = dataPicker.date
        
        let age = calendar.dateComponents([.year], from: birthday, to: dateNoew)
        let ageYear = age.year
        
        guard let ageUser = ageYear else { return false }
        
        return (ageUser > 18 ? true : false)
    }
}
