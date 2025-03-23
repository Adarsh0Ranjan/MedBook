//
//  Notification+Extension.swift
//  MedBook
//
//  Created by Adarsh Ranjan on 23/03/25.
//

import Foundation

struct NotificationData {
    static let showLoader = "showLoader"
}

extension Notification.Name {
    static let showProgressLoaderNotification = Notification.Name("showProgressLoaderNotification")
}
