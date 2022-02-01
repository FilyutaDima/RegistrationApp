//
//  SignInVC.swift
//  RegistrationApp
//
//  Created by Dmitry on 29.01.22.
//

import UIKit

class SignInVC: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initViews()
        initKeyboard()
    }
    
    @IBOutlet private final weak var createAccountButton: UIButton!
    @IBOutlet private final weak var dataEntryAreaStackView: UIStackView!
    @IBOutlet private final weak var emailTextField: UITextField!
    @IBOutlet private final weak var passwordTextField: UITextField!
    @IBOutlet private final weak var titleLabel: UILabel!
    @IBOutlet private final weak var signInButton: UIButton!
    @IBOutlet private final weak var errorLabel: UILabel!
    
    @IBAction func signInPressed(_ sender: Any) {
        if !Constants.isContaints(value: emailTextField.text ?? "", key: .email),
           !Constants.isContaints(value: passwordTextField.text ?? "", key: .password) {
            errorLabel.isHidden = false
            
        }
    }
    
    @IBAction func emailTextFieldChanged(_ sender: Any) {
        errorLabel.isHidden = true
    }
    
    @IBAction func passwordTextFieldChanged(_ sender: Any) {
        errorLabel.isHidden = true
        
    }
    
    @IBAction func goToCreateAccountVC() {
        let storyboard = UIStoryboard(name: "SignUpStoryboard", bundle: nil)
        guard let createAccountVC = storyboard.instantiateViewController(identifier: "CreateAccountVC") as? CreateAccountVC else {
            return
        }
        navigationController?.pushViewController(createAccountVC, animated: true)
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }

    }

    @objc func keyboardWillHide(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0 {
                self.view.frame.origin.y += keyboardSize.height
            }
        }
    }
    
    private func initViews() {
        Styles.applyButtonEnabledStyle(to: signInButton)
        Styles.applyTextFieldStyle(to: emailTextField)
        Styles.applyTextFieldStyle(to: passwordTextField)
        Styles.applyStackViewStyle(to: dataEntryAreaStackView)
        Styles.applyStyleRootView(to: view)
        Styles.applyTitleLabelStyle(to: titleLabel)
        Styles.applyButtonStyleWithoutBackground(to: createAccountButton)
    }
    
    private func initKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(SignInVC.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(SignInVC.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}
