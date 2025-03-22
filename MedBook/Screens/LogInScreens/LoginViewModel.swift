//
//  LoginViewModel.swift
//  MedBook
//
//  Created by Adarsh Ranjan on 22/03/25.
//


import Foundation

protocol LoginViewModelProtocol: ObservableObject {
    var email: String { get set }
    var password: String { get set }
    var isValid: Bool { get }
    
    var showEmailError: Bool { get }
    var emailErrorMessage: String { get }
    
    var showPasswordError: Bool { get }
    var passwordErrorMessage: String { get }
    
    func validateForm()
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
    
    internal func validateForm() {
        showEmailError = !email.contains("@") || !email.contains(".")
        emailErrorMessage = showEmailError ? "Enter a valid email" : ""
        
        showPasswordError = password.count < 8
        passwordErrorMessage = showPasswordError ? "Password must be at least 8 characters" : ""
        
        isValid = !showEmailError && !showPasswordError
    }
}
