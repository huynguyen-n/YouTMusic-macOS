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
}

public final class ViewModelCoordinator: ViewModelCoordinatorProtocol {
    
    public let authenViewModel: AuthenticateViewModelProtocol
    public let appViewModel: AppViewModelProtocol
    
    init(
        appViewModel: AppViewModel,
        authenViewModel: AuthenticateViewModel) {
        
        self.appViewModel = appViewModel
        self.authenViewModel = authenViewModel
    }
    
    public class func defaultYouTMusic() -> ViewModelCoordinator {
        let appViewModel = AppViewModel()
        let authenViewModel = AuthenticateViewModel()
        return ViewModelCoordinator(appViewModel: appViewModel, authenViewModel: authenViewModel)
    }
}
