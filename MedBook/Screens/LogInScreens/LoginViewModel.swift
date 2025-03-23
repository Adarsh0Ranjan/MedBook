//
//  LoginViewModel.swift
//  MedBook
//
//  Created by Adarsh Ranjan on 22/03/25.
//


import Foundation
import SwiftUI

protocol LoginViewModelProtocol: ObservableObject {
    var email: String { get set }
    var password: String { get set }
    var isValid: Bool { get }
    
    var showEmailError: Bool { get }
    var emailErrorMessage: String { get }
    
    var showPasswordError: Bool { get }
    var passwordErrorMessage: String { get }
    
    var loginErrorMessage: String? { get }
    
    func validateForm()
    func login(completion: @escaping (Bool) -> Void)
}

class LoginViewModel: LoginViewModelProtocol {
    @Published var email: String = "" {
        didSet { validateForm() }
    }
    @Published var password: String = "" {
        didSet { validateForm() }
    }
    @Published var isValid: Bool = false
    
    @Published var showEmailError: Bool = false
    @Published var emailErrorMessage: String = ""
    
    @Published var showPasswordError: Bool = false
    @Published var passwordErrorMessage: String = ""
    
    @Published var loginErrorMessage: String?
    
    private let coreDataManager: CoreDataManager
    
    init(coreDataManager: CoreDataManager = .shared) {
        self.coreDataManager = coreDataManager
    }
    
    internal func validateForm() {
        showEmailError = !email.contains("@") || !email.contains(".")
        emailErrorMessage = showEmailError ? "Enter a valid email" : ""
        
        showPasswordError = password.count < 8
        passwordErrorMessage = showPasswordError ? "Password must be at least 8 characters" : ""
        
        isValid = !showEmailError && !showPasswordError
    }
    
    func handleLogin() {
        login { success in
            if success {
                UserDefaultsHelper.saveBool(key: .isUserLoggedIn, value: true)
                AppRootView.updateRootViewTo(.homeScreen)
            }
        }
    }

    internal func login(completion: @escaping (Bool) -> Void) {
        guard isValid else {
            AlertView.show(
                alertType: .withTitleAndMessageOneButton,
                alertTitle: "Login Failed",
                alertMessage: "Invalid email or password format.",
                primaryButton: .default(Text("OK"))
            )
            completion(false)
            return
        }
        
        if let user = coreDataManager.fetchUser(email: email) {
            if user.password == password {
                completion(true)
            } else {
                AlertView.show(
                    alertType: .withTitleAndMessageOneButton,
                    alertTitle: "Login Failed",
                    alertMessage: "Incorrect password. Please try again.",
                    primaryButton: .default(Text("OK"))
                )
                completion(false)
            }
        } else {
            AlertView.show(
                alertType: .withTitleAndMessageOneButton,
                alertTitle: "Login Failed",
                alertMessage: "No account found with this email. Please sign up.",
                primaryButton: .default(Text("OK"))
            )
            completion(false)
        }
    }
}
