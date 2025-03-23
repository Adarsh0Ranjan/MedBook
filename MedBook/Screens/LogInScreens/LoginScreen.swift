//
//  LoginScreen.swift
//  MedBook
//
//  Created by Adarsh Ranjan on 22/03/25.
//

import SwiftUI

struct LoginScreen: View {
    @StateObject private var viewModel = LoginViewModel()
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
            
            Text("Welcome,")
                .font(.largeTitle).bold()
            Text("log in to continue")
                .font(.headline).foregroundColor(.gray)
            
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
            
            Spacer()
            
            AppThemeButton(
                title: "Login",
                hasArrow: true,
                isDisabled: !viewModel.isValid,
                buttonType: .coloured(fillColor: .blue, disabled: !viewModel.isValid),
                action: {
                    viewModel.handleLogin()
                }
            )
        }
        .padding()
        .navigationBarBackButtonHidden()
    }
}

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen()
    }
}
