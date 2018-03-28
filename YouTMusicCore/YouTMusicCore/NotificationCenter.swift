//
//  NotificationCenter.swift
//  YouTMusicCore
//
//  Created by Huy Nguyễn on 2/14/18.
//  Copyright © 2018 Huy Nguyen. All rights reserved.
//

import Foundation

public enum NotificationType: String {
    
    private static let NotificatioinPrefix = "com.br.youtmusic"
    
    case windowWillClose
    case showPopover
    case handleSurgeCallback
    
    func toString() -> String {
        if self.rawValue == NotificationType.windowWillClose.rawValue {
            return Notification.Name.NSThreadWillExit.rawValue
        }
        
        return NotificationType.NotificatioinPrefix + self.rawValue
    }
}

extension NotificationCenter {
    
    public class func postNotificationOnMainThreadType(_ type: NotificationType,
                                                   object: AnyObject? = nil,
                                                   userInfo: [String: Any]? = nil) {
        NotificationCenter.default.postNotificationOnMainThreadName(type.toString(), object: object, userInfo: userInfo)
    }
    
    public class func observeNotificationType(_ type: NotificationType, observer: AnyObject, selector: Selector, object anyObject: AnyObject?) {
        NotificationCenter.default.addObserver(observer, selector: selector, name: Notification.Name.init(type.rawValue), object: anyObject)
    }
    
    public class func removeAllObserver(_ observer: AnyObject) {
        NotificationCenter.default.removeObserver(observer)
    }
}


extension NotificationCenter {
    public func postNotificationOnMainThreadName(_ name: String, object: AnyObject?, userInfo: [String: Any]?) {
        let notifi = Notification(name: Notification.Name(rawValue: name), object: object, userInfo: userInfo)
        self.performSelector(onMainThread: #selector(post(_:)), with: notifi, waitUntilDone: true)
    }
}
