//
//  WelcomeVC.swift
//  RegistrationApp
//
//  Created by Dmitry on 29.01.22.
//

import UIKit

class WelcomeVC: UIViewController {

    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func continueButtonPressed() {
        saveUser()
        goToRootVC()
    }
    private func saveUser() {
        guard let user = user else { return }
        Constants.set(value: user.email, key: .email)
        Constants.set(value: user.password, key: .password)
        Constants.set(value: user.name ?? "", key: .name)
    }

    private func goToRootVC() {
        
    }
}
