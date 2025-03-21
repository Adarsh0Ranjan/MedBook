//
//  SignupViewModel.swift
//  MedBook
//
//  Created by Adarsh Ranjan on 21/03/25.
//

import Foundation

protocol SignupViewModelProtocol: ObservableObject {
    var email: String { get set }
    var password: String { get set }
    var isValid: Bool { get }
    var passwordRequirements: [Bool] { get }
    var showEmailError: Bool { get }
    var emailErrorMessage: String { get }
    var showPasswordError: Bool { get }
    var passwordErrorMessage: String { get }
}

class SignupViewModel: SignupViewModelProtocol {
    @Published var email: String = "" {
        didSet { validateForm() }
    }
    
    @Published var password: String = "" {
        didSet { validateForm() }
    }
    
    @Published private(set) var isValid: Bool = false
    @Published private(set) var passwordRequirements: [Bool] = [false, false, false]
    
    @Published private(set) var showEmailError: Bool = false
    @Published private(set) var emailErrorMessage: String = ""
    
    @Published private(set) var showPasswordError: Bool = false
    @Published private(set) var passwordErrorMessage: String = ""
    
    private func validateForm() {
        let isEmailValid = email.contains("@") && email.contains(".")
        showEmailError = !isEmailValid && !email.isEmpty
        emailErrorMessage = showEmailError ? "Please enter a valid email address" : ""
        
        passwordRequirements = [
            password.count >= 8,
            password.rangeOfCharacter(from: .uppercaseLetters) != nil,
            password.range(of: "[!@#$%^&*(),.?\":{}|<>]", options: .regularExpression) != nil
        ]
        
        showPasswordError = !password.isEmpty && !passwordRequirements.allSatisfy { $0 }
        passwordErrorMessage = showPasswordError ? "Password does not meet all requirements" : ""
        
        isValid = isEmailValid && passwordRequirements.allSatisfy { $0 }
    }
}
