//
//  UserDefaultsHelper.swift
//  MedBook
//
//  Created by Adarsh Ranjan on 23/03/25.
//

import Foundation

enum UserDefaultsKey: String {
    case isUserLoggedIn
    case userEmail
}

struct UserDefaultsHelper {
    
    static func saveBool(key: UserDefaultsKey, value: Bool) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }
    
    static func getBool(key: UserDefaultsKey) -> Bool {
        return UserDefaults.standard.bool(forKey: key.rawValue)
    }
    
    static func saveString(key: UserDefaultsKey, value: String) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }
    
    static func getString(key: UserDefaultsKey) -> String? {
        return UserDefaults.standard.string(forKey: key.rawValue)
    }
    
    static func removeValue(key: UserDefaultsKey) {
        UserDefaults.standard.removeObject(forKey: key.rawValue)
    }
}
