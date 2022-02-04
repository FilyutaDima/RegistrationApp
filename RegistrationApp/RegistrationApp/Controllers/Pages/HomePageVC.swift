//
//  HomePageVC.swift
//  RegistrationApp
//
//  Created by Dmitry on 4.02.22.
//

import UIKit

class HomePageVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initViews()
    }

    @IBOutlet private final weak var startLabel: UILabel!
    
    private func initViews() {
        Styles.applyTitleLabelStyle(to: startLabel)
        Styles.applyStyleRootView(to: view)
    }
}
