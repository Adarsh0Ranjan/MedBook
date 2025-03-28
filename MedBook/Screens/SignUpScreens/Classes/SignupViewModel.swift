//
//  SignupViewModel.swift
//  MedBook
//
//  Created by Adarsh Ranjan on 21/03/25.
//

import Foundation
import SwiftUI

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
    private let coreDataManager: CoreDataManager
    
    init(countriesService: CountriesServiceProtocol, coreDataManager: CoreDataManager = .shared) {
        self.countriesService = countriesService
        self.coreDataManager = coreDataManager
        fetchCountriesAndUserLocation()
    }
    
    func signup() {
        guard isValid else {
            AlertView.show(
                alertType: .withTitleAndMessageOneButton,
                alertTitle: "Invalid Form",
                alertMessage: "Please enter a valid email and password.",
                primaryButton: .default(Text("OK"))
            )
            return
        }
        
        if coreDataManager.isUserExists(email: email) {
            AlertView.show(
                alertType: .withTitleAndMessageOneButton,
                alertTitle: "Signup Failed",
                alertMessage: "A user with this email already exists.",
                primaryButton: .default(Text("OK"))
            )
        } else {
            coreDataManager.saveUser(email: email, password: password, country: selectedCountry)
            UserDefaultsHelper
                .saveString(key: .userEmail, value: self.email)
            AppRootView.updateRootViewTo(.homeScreen)
        }
    }


    // MARK: - Fetch Countries with Closure
    func fetchCountries(completion: @escaping ([String]?) -> Void) {
        countriesService.getCountries { result in
            switch result {
            case .success(let response):
                let countryNames = response.data.values.map { $0.country }.sorted()
                print("Fetched countries successfully")
                completion(countryNames)
            case .failure(let error):
                print("Failed to fetch countries: \(error.localizedDescription)")
                completion(nil)
            }
        }
    }
    
    // MARK: - Fetch User Location with Closure
    func fetchUserLocation(completion: @escaping (String?) -> Void) {
        print("Fetching user location...")
        countriesService.getUserLocation { result in
            switch result {
            case .success(let location):
                print("User location fetched successfully: \(location.country)")
                completion(location.country)
            case .failure(let error):
                print("Error fetching user location: \(error.localizedDescription)")
                completion(nil)
            }
        }
    }
    
    // MARK: - Fetch Data in Parallel & Update UI
    func fetchCountriesAndUserLocation() {
        
        if let savedLocation = UserDefaultsHelper.getString(key: .userLocation), !savedLocation.isEmpty {
            print("Using saved location: \(savedLocation)")
            self.selectedCountry = savedLocation
            
            // Fetch only countries since location is already available
            fetchCountries { countries in
                DispatchQueue.main.async {
                    if let countries = countries {
                        self.countries = countries
                    }
                    ActivityIndicator.hideActivityIndicator()
                }
            }
        } else {
            print("User location not found in UserDefaults. Fetching from API...")
            
            ActivityIndicator.showActivityIndicator()
            let dispatchGroup = DispatchGroup()
            var fetchedCountries: [String]?
            var fetchedUserLocation: String?
            
            dispatchGroup.enter()
            fetchCountries { countries in
                fetchedCountries = countries
                dispatchGroup.leave()
            }
            
            dispatchGroup.enter()
            fetchUserLocation { location in
                fetchedUserLocation = location
                dispatchGroup.leave()
            }
            
            dispatchGroup.notify(queue: .main) {
                self.updateUI(with: fetchedCountries, userLocation: fetchedUserLocation)
            }
        }
    }

    
    // MARK: - Update UI
    func updateUI(with countries: [String]?, userLocation: String?) {
        if let countries = countries {
            self.countries = countries
        }
        if let userLocation = userLocation {
            UserDefaultsHelper.saveString(key: .userLocation, value: userLocation)
            self.selectedCountry = userLocation
        }
        
        ActivityIndicator.hideActivityIndicator()
        print("Both countries and user location fetched. UI updated.")
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
