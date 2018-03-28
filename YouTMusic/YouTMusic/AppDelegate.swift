//
//  AppDelegate.swift
//  YouTMusic
//
//  Created by Huy Nguyễn on 2/7/18.
//  Copyright © 2018 Huy Nguyen. All rights reserved.
//

import Cocoa
import YouTMusicCore

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    fileprivate lazy var coordinator: ViewModelCoordinatorProtocol = self.initLazyViewModelCoordinator()
    
    fileprivate var popover: YouTMusicPopover!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        
        // Insert code here to initialize your application
        let selector = #selector(AppDelegate.handleGetURL(event:withReplyEvent:))
        NSAppleEventManager.shared().setEventHandler(self, andSelector: selector, forEventClass: AEEventClass(kInternetEventClass), andEventID: AEEventID(kAEGetURL))
        
        popover = YouTMusicPopover(coordinator: coordinator)
        popover.binding()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


    @objc func handleGetURL(event: NSAppleEventDescriptor, withReplyEvent: NSAppleEventDescriptor) {
        guard let url = event.paramDescriptor(forKeyword: AEKeyword(keyDirectObject))?.stringValue else {
            return
        }
        
        if url.contains("youtmusic-surge") {
            NotificationCenter.postNotificationOnMainThreadType(.handleSurgeCallback, object: event, userInfo: nil)
            return
        }
        
        YouTMusicOAuth.shareInstance.callbackObserverPublich.onNext(event)
        
    }
}

extension AppDelegate {
    func initLazyViewModelCoordinator() -> ViewModelCoordinator {
        return ViewModelCoordinator.defaultYouTMusic()
    }
}
