//
//  Styles.swift
//  RegistrationApp
//
//  Created by Dmitry on 30.01.22.
//

import Foundation
import UIKit

final class Styles {
    
    private static let cornerRadius: CGFloat = 10
    private static let borderWidth: CGFloat = 1
    private static let firstColor = #colorLiteral(red: 0.1018695459, green: 0.1359476149, blue: 0.493663311, alpha: 1)
    private static let secondColor = #colorLiteral(red: 0.2471497953, green: 0.3166205883, blue: 0.7111743689, alpha: 1)
    private static let thirdColor = #colorLiteral(red: 0.7732012868, green: 0.792005837, blue: 0.913603723, alpha: 1)
    private static let fourthColor = #colorLiteral(red: 0.9100003839, green: 0.9176246524, blue: 0.9662457108, alpha: 1)
    private static let whiteColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    
    static func applyButtonEnabledStyle(to view: UIButton) {
        view.layer.cornerRadius = cornerRadius
        view.backgroundColor = firstColor
        view.titleLabel?.tintColor = whiteColor
    }
    
    static func applyButtonDisabledStyle(to view: UIButton) {
        view.layer.cornerRadius = cornerRadius
        view.backgroundColor = thirdColor
        view.titleLabel?.textColor = whiteColor
    }
    
    static func applyButtonStyleWithoutBackground(to view: UIButton) {
        view.titleLabel?.textColor = secondColor
        view.tintColor = secondColor
    }
    
    static func applyTextFieldStyle(to view: UITextField) {
        view.layer.cornerRadius = cornerRadius
        view.backgroundColor = whiteColor
        view.textColor = firstColor
        view.layer.borderColor = thirdColor.cgColor
        view.layer.borderWidth = borderWidth
        view.attributedPlaceholder = NSAttributedString(string: view.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor : thirdColor])
    }
    
    static func applyTitleLabelStyle(to view: UILabel) {
        view.textColor = secondColor
    }
    
    static func applyTextLabelsStyle(to views: [UILabel]) {
        for view in views {
            view.textColor = secondColor
        }
    }
    
    static func applyStackViewStyle(to view: UIStackView) {
        view.layer.cornerRadius = cornerRadius
        view.backgroundColor = whiteColor
    }
    
    static func applyStyleRootView(to view: UIView) {
        view.backgroundColor = fourthColor
    }
    
    static func applyStyleProgressView(to view: UIProgressView) {
        view.trackTintColor = fourthColor
        view.transform = CGAffineTransform(scaleX: 1, y: 6)
        view.layer.cornerRadius = 3
        view.clipsToBounds = true
    }
}
