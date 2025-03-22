//
//  LandingScreen.swift
//  MedBook
//
//  Created by Adarsh Ranjan on 21/03/25.
//

import SwiftUI

struct LandingScreen: View {
    @StateObject private var viewModel = LandingViewModel()
    
    var body: some View {
        NavigationStack(path: $viewModel.navigationPath) {
            VStack {
                // App Title
                Text("MedBook")
                    .font(.largeTitle)
                    .bold()
                    .padding(.top, 40)
                
                Spacer()
                
                // Eye-catching Text Instead of an Image
                Text("Discover. Read. Bookmark.")
                    .font(.title2)
                    .foregroundColor(.blue)
                    .multilineTextAlignment(.center)
                    .padding()
                
                Spacer()
                
                // Signup & Login Buttons
                HStack(spacing: 20) {
                    AppThemeButton(
                        title: "Signup",
                        hasArrow: true,
                        buttonType: .coloured(fillColor: .blue)
                    ) {
                        viewModel.navigate(to: .signup)
                    }
                    
                    AppThemeButton(
                        title: "Login",
                        hasArrow: true,
                        buttonType: .bordered(borderColor: .gray)
                    ) {
                        viewModel.navigate(to: .login)
                    }
                }
                .padding(.horizontal, 30)
                .padding(.bottom, 40)
            }
            .background(Color(UIColor.systemGray6))
            .navigationDestination(for: Destination.self) { destination in
                switch destination {
                case .signup:
                    SignupScreen()
                case .login:
                    LoginScreen()
                }
            }
        }
    }
}


struct LandingScreen_Previews: PreviewProvider {
    static var previews: some View {
        LandingScreen()
    }
}
