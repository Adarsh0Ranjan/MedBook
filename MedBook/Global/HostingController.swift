//
//  HostingController.swift
//  MedBook
//
//  Created by Adarsh Ranjan on 23/03/25.
//

import SwiftUI

class HostingController<ContentView>: UIHostingController<ContentView> where ContentView: View {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
}
