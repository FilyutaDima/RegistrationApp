//
//  UserDefaults.swift
//  RegistrationApp
//
//  Created by Dmitry on 3.02.22.
//

import Foundation
 
class Storage {
    
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
    
    static func get(key: UserData) -> String? {
        return UserDefaults.standard.string(forKey: key.rawValue)
    }
}
