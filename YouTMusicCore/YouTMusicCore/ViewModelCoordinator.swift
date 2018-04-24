//
//  ViewModelCoordinator.swift
//  YouTMusicCore
//
//  Created by Huy Nguyễn on 2/12/18.
//  Copyright © 2018 Huy Nguyen. All rights reserved.
//

import Foundation

public protocol ViewModelCoordinatorProtocol {
    
    var appViewModel: AppViewModelProtocol { get }
    var authenViewModel: AuthenticateViewModelProtocol { get }
    var youtmServiceViewModel: YouTMusicServiceViewModelProtocol { get }
}

public final class ViewModelCoordinator: ViewModelCoordinatorProtocol {
    
    public let authenViewModel: AuthenticateViewModelProtocol
    public let appViewModel: AppViewModelProtocol
    public let youtmServiceViewModel: YouTMusicServiceViewModelProtocol
    
    init(
        appViewModel: AppViewModel,
        authenViewModel: AuthenticateViewModel,
        youtmServiceViewModel: YouTMusicServiceViewModel) {
        
        self.appViewModel = appViewModel
        self.authenViewModel = authenViewModel
        self.youtmServiceViewModel = youtmServiceViewModel
    }
    
    public class func defaultYouTMusic() -> ViewModelCoordinator {
        
        // Service
        let youtmService = YouTMusicService()
        
        // View Model
        let appViewModel = AppViewModel()
        let authenViewModel = AuthenticateViewModel()
        let youtmServiceViewModel = YouTMusicServiceViewModel(youtmService: youtmService)
        
        return ViewModelCoordinator(appViewModel: appViewModel, authenViewModel: authenViewModel, youtmServiceViewModel: youtmServiceViewModel)
    }
}
