//
//  OAuthHandler.swift
//  YouTMusicCore
//
//  Created by Huy Nguyễn on 2/9/18.
//  Copyright © 2018 Huy Nguyen. All rights reserved.
//

import Foundation
import OAuthSwift

public protocol OAuthWebviewHandlerDelegate: class {
    func oauthVisibleController() -> NSViewController
    func oauthWebviewController(_ url: URL) -> NSViewController
}


public class OAuthWebviewHandler: OAuthSwiftURLHandlerType {
    
    fileprivate var visibleController: NSViewController {
        return self.delegate!.oauthVisibleController()
    }
    
    fileprivate var observers = [String: AnyObject]()
    public weak var delegate: OAuthWebviewHandlerDelegate?
    
    open var presentCompletion: (()-> Void)?
    open var dismissCompletion: (()-> Void)?
    
    public init() {}
    
    @objc public func handle(_ url: URL) {
        
        let webController = self.delegate!.oauthWebviewController(url)
        
        DispatchQueue.main.async { [weak self] in
            guard let `self` = self else { return }
            self.visibleController.presentViewControllerAsSheet(webController)
        }
        
        let key = UUID().uuidString
        
        observers[key] = OAuthSwift.notificationCenter.addObserver(
            forName: NSNotification.Name.OAuthSwiftHandleCallbackURL,
            object: nil,
            queue: OperationQueue.main,
            using: { [weak self] _ in
                guard let `self` = self else { return }
                
                if let observer = `self`.observers[key] {
                    OAuthSwift.notificationCenter.removeObserver(observer)
                    `self`.observers.removeValue(forKey: key)
                }
                
                DispatchQueue.main.async { [weak self] in
                    guard let `self` = self else { return }
                    self.visibleController.dismissViewController(webController)
                }
        })
    }
}
