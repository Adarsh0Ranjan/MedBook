//
//  SignupScreen.swift
//  MedBook
//
//  Created by Adarsh Ranjan on 21/03/25.
//

import SwiftUI

struct SignupScreen: View {
    @StateObject private var viewModel = SignupViewModel(
        countriesService: CountriesService()
    )
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Button(action: { presentationMode.wrappedValue.dismiss() }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.blue)
                        .font(.system(size: 20, weight: .bold))
                }
                Spacer()
            }
            .padding(.bottom, 10)
            
            Text("Welcome")
                .font(.largeTitle).bold()
            Text("Sign up to continue")
                .font(.headline)
                .foregroundColor(.gray)
            
            AppThemeTextField(
                title: "Email",
                placeholder: "Enter your email",
                text: $viewModel.email,
                keyboardType: .emailAddress,
                showError: viewModel.showEmailError,
                errorMessage: viewModel.emailErrorMessage
            )
            
            AppThemeTextField(
                title: "Password",
                placeholder: "Enter your password",
                text: $viewModel.password,
                isSecure: true,
                showError: viewModel.showPasswordError,
                errorMessage: viewModel.passwordErrorMessage
            )
            
            VStack(alignment: .leading, spacing: 5) {
                RequirementText(text: "At least 8 characters", isMet: viewModel.passwordRequirements[0])
                RequirementText(text: "Must contain an uppercase letter", isMet: viewModel.passwordRequirements[1])
                RequirementText(text: "Contains a special character", isMet: viewModel.passwordRequirements[2])
            }
            
            VStack(alignment: .leading) {
                Text("Select Country")
                    .font(.headline)
                    .foregroundColor(.gray)
                
                Picker("Country", selection: $viewModel.selectedCountry) {
                    ForEach(viewModel.countries, id: \.self) { country in
                        Text(country).tag(country)
                    }
                }
                .frame(height: 144)
                .clipped()
                .pickerStyle(WheelPickerStyle())
            }
            .padding(.vertical, 10)
            
            Spacer()
            
            AppThemeButton(
                title: "Let's go",
                hasArrow: true,
                isDisabled: !viewModel.isValid,
                buttonType: .coloured(fillColor: .blue, disabled: !viewModel.isValid),
                action: { /* Handle signup action */ }
            )
        }
        .padding()
        .navigationBarBackButtonHidden()
    }
}

struct SignupScreen_Previews: PreviewProvider {
    static var previews: some View {
        SignupScreen()
    }
}
