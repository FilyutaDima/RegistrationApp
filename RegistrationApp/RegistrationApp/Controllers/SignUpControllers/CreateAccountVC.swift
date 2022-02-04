//
//  CreateAccountVC.swift
//  RegistrationApp
//
//  Created by Dmitry on 29.01.22.
//

import UIKit

enum Rules {
    case email
    case password
    case mismatchPasswords
}

class CreateAccountVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initViews()
        initKeyboardObserver()
        hideKeyboardWhenTappedAround()
    }
    
    @IBOutlet weak var scrollView: UIScrollView!
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
    
    private var rules: [Rules: Bool] = [.email : false, .password: false, .mismatchPasswords : false] {
        didSet {
            if rules[.email] == true,
               rules[.password] == true,
               rules[.mismatchPasswords] == true {
                signUpButton.isEnabled = true
                Styles.applyButtonEnabledStyle(to: signUpButton)
            } else {
                signUpButton.isEnabled = false
                Styles.applyButtonDisabledStyle(to: signUpButton)
            }
        }
    }
    
    @IBAction func emailTextFieldChanged(_ sender: UITextField) {
        
        if VerificationService.isValidEmail(email: sender.text ?? "") {
            emailErrorLabel.isHidden = true
            rules[.email] = true
        } else {
            emailErrorLabel.isHidden = false
            rules[.email] = false
        }
    }
    
    @IBAction func passwordTextFieldChanged(_ sender: UITextField) {
        let pass1 = sender.text ?? ""
        let pass2 = confirmPasswordTextField.text ?? ""
        
        if VerificationService.isLongPassword(pass: pass1) {
            passwordErrorLabel.isHidden = true
            rules[.password] = true
        } else {
            passwordErrorLabel.isHidden = false
            rules[.password] = false
        }
        
        updatePasswordStrengthProgressView(with: pass1)
        if pass2.count > 0 {
            checkPasswordsMatch(pass1: pass1, pass2: pass2)
        }
    }
    
    @IBAction func confirmPasswordTextFieldChanged(_ sender: UITextField) {
        let pass1 = passwordTextField.text ?? ""
        let pass2 = sender.text ?? ""
        
        checkPasswordsMatch(pass1: pass1, pass2: pass2)
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
    
    private func updatePasswordStrengthProgressView(with password: String) {
        if password.count >= 8 {
            switch VerificationService.isValidPassword(pass: password) {
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
    
    private func checkPasswordsMatch(pass1: String, pass2: String) {
        if VerificationService.isPassConfirm(pass1: pass1, pass2: pass2) {
            confirmPasswordErrorLabel.isHidden = true
            rules[.mismatchPasswords] = true
        } else {
            confirmPasswordErrorLabel.isHidden = false
            rules[.mismatchPasswords] = false
        }
    }
    
    private func initKeyboardObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(SignInVC.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(SignInVC.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}
