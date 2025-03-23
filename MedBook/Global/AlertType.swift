//
//  AlertType.swift
//  MedBook
//
//  Created by Adarsh Ranjan on 23/03/25.
//


import Foundation
import SwiftUI

enum AlertType {
    case withTitle
    case withTitleAndTwoButtons
    case withTitleAndMessageTwoButtons
    case withTitleAndMessageOneButton
}

struct AlertView: View {
    @State var alertType: AlertType = .withTitle
    @State var selectedShow: Bool = false
    @State var title = ""
    @State var message = ""
    @State var primaryButton: Alert.Button?
    @State var secondButton: Alert.Button?

    var body: some View {
        ZStack {}.onReceive(NotificationCenter.default.publisher(for: .showAlertViewNotification)) { data in
            
            guard let userInfo = data.userInfo, let shouldShowAlert = userInfo[NotificationData.showAlert] else {
                selectedShow = false
                return
            }
            self.primaryButton = userInfo[NotificationData.alertPrimaryButton] as? Alert.Button
            self.secondButton = userInfo[NotificationData.alertSecondButton] as? Alert.Button
            self.message = userInfo[NotificationData.alertMessage] as? String ?? ""
            self.title = userInfo[NotificationData.alertTitle] as? String ?? ""
            self.alertType = userInfo[NotificationData.alertType] as? AlertType ?? .withTitleAndMessageOneButton
            
            self.selectedShow = shouldShowAlert as? Bool ?? false
        }
        .alert(isPresented: $selectedShow, content: { () -> Alert in
            getAlertBasedOnType()
        }).opacity(selectedShow ? 1 : 0)
    }
    
    private func getAlertBasedOnType() -> Alert {
        if alertType == .some(.withTitle) {
            return Alert(title: Text(title))
        } else if alertType == .some(.withTitleAndTwoButtons) {
            return Alert(title: Text(title), primaryButton: primaryButton!, secondaryButton: secondButton!)
        } else if alertType == .some(.withTitleAndMessageTwoButtons) {
            return Alert(title: Text(title), message: Text(message), primaryButton: primaryButton!, secondaryButton: secondButton!)
        } else if alertType == .some(.withTitleAndMessageOneButton) {
           return Alert(title: Text(title), message: Text(message), dismissButton: primaryButton!)
        }
        return Alert(title: Text(title))
    }
    
    static func show(alertType: AlertType = .withTitleAndMessageOneButton, alertTitle: String = "Error", alertMessage: String, primaryButton: Alert.Button, secondButton: Alert.Button? = nil) {
        updateAlertViewVisibility(alertMessage: alertMessage, alertTitle: alertTitle, alertType: alertType, primaryButton: primaryButton, secondButton: secondButton)
    }
       
    static func hide() {
        NotificationCenter.default.post(name: .showAlertViewNotification, object: nil, userInfo: nil)
    }
    
    private static func updateAlertViewVisibility(alertMessage: String, alertTitle: String, alertType: AlertType, primaryButton: Alert.Button, secondButton: Alert.Button?) {
        DispatchQueue.main.async {
            NotificationCenter.default.post(name: .showAlertViewNotification, object: nil, userInfo: [NotificationData.showAlert: true, NotificationData.alertMessage: alertMessage, NotificationData.alertTitle: alertTitle, NotificationData.alertType: alertType, NotificationData.alertPrimaryButton: primaryButton,
                NotificationData.alertSecondButton: secondButton])
        }
    }
}
