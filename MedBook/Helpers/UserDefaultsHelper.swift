//
//  UserDefaultsHelper.swift
//  MedBook
//
//  Created by Adarsh Ranjan on 23/03/25.
//

import Foundation

enum UserDefaultsKey: String {
    case isUserLoggedIn
    case username
}

struct UserDefaultsHelper {
    
    static func saveBool(key: UserDefaultsKey, value: Bool) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }
    
    static func getBool(key: UserDefaultsKey) -> Bool {
        return UserDefaults.standard.bool(forKey: key.rawValue)
    }
}
