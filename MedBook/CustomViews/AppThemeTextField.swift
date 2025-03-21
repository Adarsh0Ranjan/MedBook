//
//  AppThemeTextField.swift
//  MedBook
//
//  Created by Adarsh Ranjan on 21/03/25.
//


import SwiftUI

struct AppThemeTextField: View {
    var title: String
    var placeholder: String
    @Binding var text: String
    var isSecure: Bool = false
    var keyboardType: UIKeyboardType = .default
    var showError: Bool = false
    var errorMessage: String = ""
    
    @State private var showPassword: Bool = false
    @State private var shouldShowError: Bool = false // Tracks when to show error
    @FocusState private var isFocused: Bool // Detects if the field is active
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(isFocused ? Color.blue : Color.gray, lineWidth: 1)
                    .frame(height: 50)
                    .background(Color.white)
                
                // Floating Title
                Text(title)
                    .foregroundColor(isFocused || !text.isEmpty ? Color.blue : Color.gray)
                    .font(.caption)
                    .background(Color.white)
                    .padding(.horizontal, 8)
                    .offset(y: isFocused || !text.isEmpty ? -25 : 0) // Moves up only on focus or if text exists
                    .animation(.easeInOut(duration: 0.2), value: isFocused || !text.isEmpty)
                
                HStack {
                    if isSecure && !showPassword {
                        SecureField("", text: $text)
                            .keyboardType(keyboardType)
                            .padding(.leading, 12)
                            .focused($isFocused)
                            .onChange(of: text) {
                                shouldShowError = false
                            }
                    } else {
                        TextField("", text: $text)
                            .keyboardType(keyboardType)
                            .padding(.leading, 12)
                            .focused($isFocused)
                            .onChange(of: text) {
                                shouldShowError = false
                            }
                    }
                    
                    if isSecure {
                        Button(action: {
                            showPassword.toggle()
                        }) {
                            Image(systemName: showPassword ? "eye.slash" : "eye")
                                .foregroundColor(.gray)
                        }
                        .padding(.trailing, 12)
                    }
                }
                .frame(height: 50)
            }
            
            if shouldShowError {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .font(.caption)
                    .padding(.leading, 5)
            }
        }
        .onChange(of: isFocused) {
            if !isFocused { // When focus is lost
                shouldShowError = showError
            }
        }
    }
}

struct AppThemeTextField_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 20) {
            AppThemeTextField(title: "Email", placeholder: "Enter your email", text: .constant(""), showError: true, errorMessage: "Invalid email")
            AppThemeTextField(title: "Password", placeholder: "Enter your password", text: .constant(""), isSecure: true, showError: true, errorMessage: "Password required")
        }
        .padding()
    }
}
