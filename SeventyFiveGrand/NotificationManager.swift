//
//  NotificationManager.swift
//  SeventyFiveGrand
//
//  Created by Jerome Paulos on 12/19/22.
//

import Foundation
import UserNotifications

struct NotificationManager {
    
    static let center = UNUserNotificationCenter.current()
    
    static func requestPermission() {
        center.requestAuthorization(options: [.alert, .badge]) { granted, error in
            print("Notification permission granted: \(granted)")
        }
    }

}
