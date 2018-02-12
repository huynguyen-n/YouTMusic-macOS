//
//  YouTMusicPopover.swift
//  YouTMusic
//
//  Created by Huy Nguyễn on 2/12/18.
//  Copyright © 2018 Huy Nguyen. All rights reserved.
//

import Cocoa
import RxSwift
import RxCocoa
import YouTMusicCore

class YouTMusicPopover: NSPopover {
    
    fileprivate let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    fileprivate let authenticateModel: AuthenticateViewModelProtocol
    fileprivate let disposeBags = DisposeBag()
    
    override init() {
        authenticateModel = AuthenticateViewModel()
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension YouTMusicPopover {
    
    fileprivate func handleClose() {
        if !isShown { return }
        performClose(nil)
//        eventMonitor.stop()
    }
    
    fileprivate func handleShow() {
        
        NSRunningApplication.current.activate(options: NSApplication.ActivationOptions.activateIgnoringOtherApps)
        
        guard let button = statusItem.button else {
            return
        }
        
        show(relativeTo: button.frame, of: button, preferredEdge: .minY)
//        eventMonitor.start()
    }
}
