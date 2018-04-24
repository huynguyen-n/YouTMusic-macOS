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
    fileprivate let viewModel: AppViewModelProtocol
    fileprivate let disposeBag = DisposeBag()
    fileprivate let coordinator: ViewModelCoordinatorProtocol
    
    init(coordinator: ViewModelCoordinatorProtocol) {
        self.coordinator = coordinator
        viewModel = coordinator.appViewModel
        authenticateModel = AuthenticateViewModel()
        
        super.init()
        delegate = self
        initCommon()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func togglePopover() {
        if isShown {
            viewModel.input.actionPopoverPublish.onNext(.close)
        } else {
            viewModel.input.actionPopoverPublish.onNext(.open)
        }
    }
    
    public func binding() {
        
        authenticateModel.output.authenticateStateDriver.drive(onNext: { [weak self] state in
            guard let `self` = self else { return }
            
            self.setupContentController(with: state)
        }).disposed(by: disposeBag)
        
        viewModel.output.popoverStateVariable.asDriver().skip(1).drive(onNext: { [weak self] state in
            guard let `self` = self else { return }
            
            switch state {
            case .open:
                self.handleShow()
            case .close:
                self.handleClose()
            }
        }).disposed(by: disposeBag)
    }
    
    fileprivate func setupContentController(with state: AuthenticateState) {
        
        switch state {
        case .authenticated:
            contentViewController = FeedViewController.buildController(coordinator)
        case .unAuthenticated:
            contentViewController = LoginViewController.buildController(coordinator)
        }
    }
}

extension YouTMusicPopover: NSPopoverDelegate {
    
}

extension YouTMusicPopover {

    fileprivate func initCommon() {
        if let button = statusItem.button {
            button.image = NSImage(imageLiteralResourceName: "YouTStatusBarImage")
            button.imagePosition = .imageLeft
            button.action = #selector(togglePopover)
            button.target = self
        }
        
        appearance = NSAppearance(named: NSAppearance.Name.vibrantDark)
    }
    
    fileprivate func handleClose() {
        if !isShown { return }
        performClose(nil)
    }
    
    fileprivate func handleShow() {
        
        NSRunningApplication.current.activate(options: NSApplication.ActivationOptions.activateIgnoringOtherApps)
        
        guard let button = statusItem.button else {
            return
        }
        
        show(relativeTo: button.frame, of: button, preferredEdge: .minY)
    }
}
