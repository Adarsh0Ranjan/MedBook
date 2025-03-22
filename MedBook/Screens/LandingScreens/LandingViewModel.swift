//
//  LandingViewModel.swift
//  MedBook
//
//  Created by Adarsh Ranjan on 22/03/25.
//

import Foundation
import SwiftUI

class LandingViewModel: ObservableObject {
    @Published var navigationPath = NavigationPath()
    
    func navigate(to destination: Destination) {
        navigationPath.append(destination)
    }
}


