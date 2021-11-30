import Foundation
import UIKit

extension AuthViewController {
    
    @objc func signInButtonTapped() {
        
        let mail = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        let user = findUserDataBase(mail: mail)
        
        if user == nil {
            loginLabel.text = "User not found"
            loginLabel.textColor = .red
        } else if user?.password == password {
            
            let navigationViewController = UINavigationController(rootViewController: AlbumsViewController())
            navigationViewController.modalPresentationStyle = .fullScreen
            self.present(navigationViewController, animated: true)
            
            guard let activeUser = user else { return }
            
            DataBase.shared.saveActiveUser(user: activeUser)
        } else {
            loginLabel.text = "Incorrect password"
            loginLabel.textColor = .red
        }
    }
    
    @objc func signUpButtonTapped() {
        let signUpViewController = SignUpViewController()
        self.present(signUpViewController, animated: true)
    }
    
    func findUserDataBase(mail: String) -> User? {
        
        let dataBase = DataBase.shared.users
        
        for user in dataBase {
            if user.email == mail {
                return user
            }
        }
        
        return nil
    }
}

