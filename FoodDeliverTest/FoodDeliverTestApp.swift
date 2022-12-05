//
//  FoodDeliverTestApp.swift
//  FoodDeliverTest
//
//  Created by Muhammad Umair on 03/12/2022.
//

import SwiftUI

@main
struct FoodDeliverTestApp: App {
    let center = UNUserNotificationCenter.current()
    
    init() {
        registerForNotification()
    }
    
    func registerForNotification() {
        UIApplication.shared.registerForRemoteNotifications()
        let center : UNUserNotificationCenter = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.sound , .alert , .badge ], completionHandler: { (granted, error) in
            if ((error != nil)) { UIApplication.shared.registerForRemoteNotifications() }
            else {
                
            }
        })
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
