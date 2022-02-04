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
        initKeyboardObserver()
        hideKeyboardWhenTappedAround()
    }
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet private final weak var createAccountButton: UIButton!
    @IBOutlet private final weak var dataEntryAreaStackView: UIStackView!
    @IBOutlet private final weak var emailTextField: UITextField!
    @IBOutlet private final weak var passwordTextField: UITextField!
    @IBOutlet private final weak var titleLabel: UILabel!
    @IBOutlet private final weak var signInButton: UIButton!
    @IBOutlet private final weak var errorLabel: UILabel!
    
    @IBAction func signInPressed(_ sender: Any) {
        if !Storage.isContaints(value: emailTextField.text ?? "", key: .email),
           !Storage.isContaints(value: passwordTextField.text ?? "", key: .password) {
            errorLabel.isHidden = false
        } else {
            performSegue(withIdentifier: "goToHomePage", sender: nil)
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
            let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
            scrollView.contentInset = contentInsets
            scrollView.scrollIndicatorInsets = contentInsets
        }

    }

    @objc func keyboardWillHide(notification: Notification) {
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
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
    
    private func initKeyboardObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(SignInVC.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(SignInVC.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @IBAction func unwindToFirstVC(_ unwindSegue: UIStoryboardSegue) { }
}
