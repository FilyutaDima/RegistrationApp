//
//  CreateAccountVC.swift
//  RegistrationApp
//
//  Created by Dmitry on 29.01.22.
//

import UIKit

class CreateAccountVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initViews()
        initKeyboard()
    }
    
    @IBOutlet private final weak var titleLabel: UILabel!
    @IBOutlet private final var textLabels: [UILabel]!
    @IBOutlet private final weak var signInButton: UIButton!
    @IBOutlet private final weak var emailTextField: UITextField!
    @IBOutlet private final weak var nameTextField: UITextField!
    @IBOutlet private final weak var passwordTextField: UITextField!
    @IBOutlet private final weak var confirmPasswordTextField: UITextField!
    @IBOutlet private final weak var emailErrorLabel: UILabel!
    @IBOutlet private final weak var passwordErrorLabel: UILabel!
    @IBOutlet private final weak var confirmPasswordErrorLabel: UILabel!
    @IBOutlet private final weak var signUpButton: UIButton!
    @IBOutlet private final weak var passwordStrengthProgressView: UIProgressView!
    @IBOutlet private final weak var dataEntryAreaStackView: UIStackView!
    
    private var rules = ["Email" : false, "Strong password" : false, "Mismatch passwords" : false] {
        didSet {
            if rules["Email"] == true,
                rules["Strong password"] == true,
                rules["Mismatch passwords"] == true {
                signUpButton.isEnabled = true
                Styles.applyButtonEnabledStyle(to: signUpButton)
            } else {
                signUpButton.isEnabled = false
                Styles.applyButtonDisabledStyle(to: signUpButton)
            }
        }
    }
    
    private func initViews() {
        Styles.applyTitleLabelStyle(to: titleLabel)
        Styles.applyTextLabelsStyle(to: textLabels)
        Styles.applyButtonStyleWithoutBackground(to: signInButton)
        Styles.applyTextFieldStyle(to: emailTextField)
        Styles.applyTextFieldStyle(to: nameTextField)
        Styles.applyTextFieldStyle(to: passwordTextField)
        Styles.applyTextFieldStyle(to: confirmPasswordTextField)
        Styles.applyButtonDisabledStyle(to: signUpButton)
        Styles.applyStyleRootView(to: view)
        Styles.applyStackViewStyle(to: dataEntryAreaStackView)
        Styles.applyStyleProgressView(to: passwordStrengthProgressView)
    }
    
    private func initKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(SignInVC.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(SignInVC.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    @IBAction func emailTextFieldChanged(_ sender: UITextField) {
        
        if VerificationService.isValidEmail(email: sender.text ?? "") {
            emailErrorLabel.isHidden = true
            rules["Email"] = true
        } else {
            emailErrorLabel.isHidden = false
            rules["Email"] = false
        }
    }
    
    @IBAction func passwordTextFieldChanged(_ sender: UITextField) {
        let pass = sender.text ?? ""
        
        if VerificationService.isLongPassword(pass: pass) {
            passwordErrorLabel.isHidden = true
            rules["Strong password"] = true
        } else {
            passwordErrorLabel.isHidden = false
            rules["Strong password"] = false
        }
        
        if pass.count >= 8 {
            switch VerificationService.isValidPassword(pass: pass) {
            case .veryWeak:
                setProgress(strength: .veryWeak, color: .red)
            case .weak:
                setProgress(strength: .weak, color: .brown)
            case .notVeryWeak:
                setProgress(strength: .notVeryWeak, color: .yellow)
            case .notVeryStrong:
                setProgress(strength: .notVeryStrong, color: .blue)
            case .strong:
                setProgress(strength: .strong, color: .green)
            }
        } else {
            resetProgress()
        }
    }
    
    @IBAction func confirmPasswordTextFieldChanged(_ sender: UITextField) {
        let pass1 = passwordTextField.text ?? ""
        let pass2 = sender.text ?? ""
        
        if VerificationService.isPassConfirm(pass1: pass1, pass2: pass2) {
            confirmPasswordErrorLabel.isHidden = true
            rules["Mismatch passwords"] = true
        } else {
            confirmPasswordErrorLabel.isHidden = false
            rules["Mismatch passwords"] = false
        }
    }
    
    @IBAction func signInButtonPressed() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    
    @IBAction func signUpButtonPressed() {
        let user = User(name: nameTextField.text,
                        email: emailTextField.text!,
                        password: passwordTextField.text!)
        
        performSegue(withIdentifier: "goToCodeVerifVC", sender: user)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if let codeVerifVC = segue.destination as? CodeVerifVC,
           let user = sender as? User
        {
            codeVerifVC.user = user
        }
    }
    
    
    private func setProgress(strength: PasswordStrength, color: UIColor) {
        passwordStrengthProgressView.progress = strength.rawValue
        passwordStrengthProgressView.progressTintColor = color
    }
    
    private func resetProgress() {
        passwordStrengthProgressView.progress = 0.0
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
}
