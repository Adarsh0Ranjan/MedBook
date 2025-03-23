//
//  Notification+Extension.swift
//  MedBook
//
//  Created by Adarsh Ranjan on 23/03/25.
//

import Foundation

struct NotificationData {
    static let showLoader = "showLoader"
    static let showAlert = "showAlert"
    static let alertMessage = "alertMessage"
    static let alertTitle = "alertTitle"
    static let alertType = "alertType"
    static let alertPrimaryButton = "alertPrimaryButton"
    static let alertSecondButton = "alertSecondButton"
}

extension Notification.Name {
    static let showProgressLoaderNotification = Notification.Name("showProgressLoaderNotification")
    static let showAlertViewNotification = Notification.Name("showAlertViewNotification")
}
