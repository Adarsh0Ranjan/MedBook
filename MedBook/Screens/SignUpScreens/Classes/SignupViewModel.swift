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
    var selectedCountry: String { get set }
    var countries: [String] { get }
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
    
    @Published var selectedCountry: String = "Select a country"
    @Published private(set) var countries: [String] = []
    
    private let countriesService: CountriesServiceProtocol
    
    init(countriesService: CountriesServiceProtocol) {
        self.countriesService = countriesService
        getCountries()
        getUserLocation()
    }
    
    func getCountries() {
        countriesService.getCountries { result in
            switch result {
            case .success(let response):
                let countryNames = response.data.values.map { $0.country }
                DispatchQueue.main.async {
                    self.countries = countryNames.sorted()
                }
            case .failure(let error):
                print("Failed to fetch countries: \(error.localizedDescription)")
            }
        }
    }
    
    func getUserLocation() {
        print("Fetching user location...") // Log start of location fetch
        countriesService.getUserLocation { result in
            switch result {
            case .success(let location):
                DispatchQueue.main.async {
                    self.selectedCountry = location.country
                    print("User location fetched successfully: \(location.country)") // Log success with country name
                }
            case .failure(let error):
                print("Error fetching user location: \(error.localizedDescription)") // Log failure with error details
            }
        }
    }

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
