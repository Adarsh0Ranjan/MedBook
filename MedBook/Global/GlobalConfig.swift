//
//  GlobalConfig.swift
//  MedBook
//
//  Created by Adarsh Ranjan on 23/03/25.
//


struct GlobalConfig {
    static var currentUserEmail: String {
        return UserDefaultsHelper.getString(key: .userEmail) ?? ""
    }
}
