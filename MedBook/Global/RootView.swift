//
//  RootView.swift
//  MedBook
//
//  Created by Adarsh Ranjan on 23/03/25.
//

import SwiftUI

enum RootView {
    case landingScreen
    case homeScreen
}

struct AppRootView: View {
    @State var rootView: RootView
    
    var body: some View {
        Group {
            switch rootView {
            case .landingScreen:
                LandingScreen()
            case .homeScreen:
                HomeView()
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: .updateRootViewNotification)) { notification in
            if let newRootView = notification.userInfo?[NotificationData.rootViewType] as? RootView {
                rootView = newRootView
            }
        }
    }
    
    static func updateRootViewTo(_ rootView: RootView) {
        DispatchQueue.main.async {
            NotificationCenter.default.post(name: .updateRootViewNotification, object: nil, userInfo: [NotificationData.rootViewType: rootView])
        }
    }
}

