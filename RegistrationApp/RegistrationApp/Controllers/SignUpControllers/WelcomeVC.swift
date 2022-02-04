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
        initViews()
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var continueButton: UIButton!
    
    @IBAction func continueButtonPressed() {
        saveUser()
        goToRootVC()
    }
    
    private func saveUser() {
        guard let user = user else { return }
        Storage.set(value: user.email, key: .email)
        Storage.set(value: user.password, key: .password)
        Storage.set(value: user.name ?? "", key: .name)
    }

    private func goToRootVC() {
        performSegue(withIdentifier: "unwindToFirstVC", sender: nil)
    }
    
    private func initViews() {
        Styles.applyStyleRootView(to: view)
        Styles.applyTitleLabelStyle(to: titleLabel)
        Styles.applyTextLabelsStyle(to: [textLabel])
        Styles.applyButtonEnabledStyle(to: continueButton)
    }
}
