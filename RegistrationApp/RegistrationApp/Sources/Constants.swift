//
//  Constants.swift
//  RegistrationApp
//
//  Created by Dmitry on 29.01.22.
//

import Foundation

class Constants {
    
    enum UserData: String {
        case password = "Password"
        case email = "Email"
        case name = "Name"
    }
    
    static func set(value: String, key: UserData) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }
    
    static func isContaints(value: String, key: UserData) -> Bool {
        return UserDefaults.standard.string(forKey: key.rawValue) == value
    }
    
    static func deleteUserInfo(){
        
    }
}
