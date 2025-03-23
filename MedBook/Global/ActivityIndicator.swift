//
//  ActivityIndicator.swift
//  MedBook
//
//  Created by Adarsh Ranjan on 23/03/25.
//


import SwiftUI

struct ActivityIndicator: View {
    @State var shouldShowLoader = false
    static var isShowBackground = false
    
    static var isLoaderShown = false
    // the variable isLoaderShown defined to determine the behavior of progress loader is shown or not, this is needed to check wheather we need to show retry dialog of internet connectivity or not
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color.black.opacity(0.5))
                .edgesIgnoringSafeArea(.all)
            
            if ActivityIndicator.isShowBackground {
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.black.opacity(0.50))
                    .frame(width: 80, height: 80, alignment: .center)
            }
            
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: Color.white))
                .scaleEffect(x: 2, y: 2, anchor: .center)
        }
        .onReceive(NotificationCenter.default.publisher(for: .showProgressLoaderNotification)) { data in
            guard let userInfo = data.userInfo, let shouldShowLoader = userInfo[NotificationData.showLoader] else {
                shouldShowLoader = false
                return
            }
            self.shouldShowLoader = shouldShowLoader as? Bool ?? false
        }
        .opacity(shouldShowLoader ? 1 : 0)
    }
   
    static func showActivityIndicator(isShowBackground: Bool = false) {
        self.isShowBackground = isShowBackground
        isLoaderShown = true
        updateActivityIndicatorVisibility(shouldShow: true)
    }
    
    static func hideActivityIndicator() {
        if isShowBackground {
            self.isShowBackground = false
        }
        isLoaderShown = false
        updateActivityIndicatorVisibility(shouldShow: false)
    }
    
    private static func updateActivityIndicatorVisibility(shouldShow: Bool) {
        NotificationCenter.default.post(name: .showProgressLoaderNotification, object: nil, userInfo: [NotificationData.showLoader: shouldShow])
    }
}
