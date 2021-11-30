import Foundation
import UIKit

extension AuthViewController {
    
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
    
    @objc func keyboardWillShow(notification: Notification) {
        let userInfo = notification.userInfo
        let heigtKeyboard = (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        scrollView.contentOffset = CGPoint(x: 0, y: heigtKeyboard.height / 2)
        
        
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        scrollView.contentOffset = CGPoint.zero
    }
}
    
extension AuthViewController {
    func setupConstraints() {
            
        scrollView.snp.makeConstraints {
                $0.edges.equalToSuperview()
        }
            
        backgroundView.snp.makeConstraints {
            $0.centerX.centerY.equalTo(scrollView)
            $0.width.height.equalToSuperview()
        }
                
        textFieldsStackView.snp.makeConstraints {
            $0.centerY.centerX.equalTo(backgroundView)
            $0.leading.equalTo(backgroundView).inset(20)
            $0.trailing.equalTo(backgroundView).offset(-20)
        }
                
        buttonsStackView.snp.makeConstraints {
            $0.leading.equalTo(backgroundView).inset(20)
            $0.trailing.equalTo(backgroundView).offset(-20)
            $0.top.equalTo(textFieldsStackView.snp.bottom).offset(30)
            }
                
        loginLabel.snp.makeConstraints {
            $0.centerX.equalTo(backgroundView)
            $0.bottom.equalTo(textFieldsStackView.snp.top).offset(-30)
        }
                
        signUpButton.snp.makeConstraints {
            $0.height.equalTo(40)
        }
                
        signInButton.snp.makeConstraints {
            $0.height.equalTo(40)
        }
    }
}
