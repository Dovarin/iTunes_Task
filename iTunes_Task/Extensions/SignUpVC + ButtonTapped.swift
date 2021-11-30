import Foundation

extension SignUpViewController {
    
    @objc func signUpButtonTapped() {
        
        let firstname = firstNameTextField.text ?? ""
        let secondName = secondNameTextField.text ?? ""
        let phone = phoneNumberTextField.text ?? ""
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        if firstname.isValid(nameValueType) && secondName.isValid(nameValueType) && email.isValid(emailValueType) && password.isValid(passwoftValueType) && phone.count == 18 && ageIsValid() == true {
            
            DataBase.shared.saveUser(firstName: firstname,
                                     secondName: secondName,
                                     phone: phone,
                                     email: email,
                                     password: password,
                                     age: dataPicker.date)
            
            loginLabel.text = "Registration was successful, confirm login"
            
        } else {
            alertError(title: "Error", message: "Registration for 18+ y.o. users only")
        }
    }
}
