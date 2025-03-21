//
//  LandingScreen.swift
//  MedBook
//
//  Created by Adarsh Ranjan on 21/03/25.
//

import SwiftUI

struct LandingScreen: View {
    var body: some View {
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
                    hasArrow: true, buttonType: .coloured(fillColor: .blue)
                ) {
                    // Navigate to Signup
                }
                
                AppThemeButton(
                    title: "Login",
                    hasArrow: true, buttonType: .bordered(borderColor: .gray)
                ) {
                    // Navigate to Login
                }
            }
            .padding(.horizontal, 30)
            .padding(.bottom, 40)
        }
        .background(Color(UIColor.systemGray6))
    }
}

struct LandingScreen_Previews: PreviewProvider {
    static var previews: some View {
        LandingScreen()
    }
}
