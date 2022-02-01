//
//  CodeVerifVC.swift
//  RegistrationApp
//
//  Created by Dmitry on 29.01.22.
//

import UIKit

class CodeVerifVC: UIViewController {
    
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        generateRandomCode()
        
    }
    
    @IBOutlet private final weak var randomCodeLabel: UILabel!
    @IBAction private final func enteredCode(_ sender: UITextField) {
        if let code1 = sender.text, let code2 = randomCodeLabel.text, code1.elementsEqual(code2) {
            goToWelcomeVC()
        }
    }
    
    private func generateRandomCode() {
        randomCodeLabel.text = String(Int.random(in: 100000...999999))
    }
    
    @IBAction func goToWelcomeVC() {
        guard let user = user else {
            return
        }
        performSegue(withIdentifier: "goToWelcomeVC", sender: user)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if let welcomeVC = segue.destination as? WelcomeVC,
           let user = sender as? User
        {
            welcomeVC.user = user
        }
    }
}
