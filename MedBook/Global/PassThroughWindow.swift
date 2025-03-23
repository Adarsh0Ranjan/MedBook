//
//  PassThroughWindow.swift
//  MedBook
//
//  Created by Adarsh Ranjan on 23/03/25.
//


import UIKit

class PassThroughWindow: UIWindow {
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        // Get view from superclass.
        guard let hitView = super.hitTest(point, with: event) else { return nil }
        // If the returned view is the `UIHostingController`'s view, ignore.
        return rootViewController?.view == hitView ? nil : hitView
    }
}
