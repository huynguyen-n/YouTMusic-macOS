//
//  ViewModelCoordinator.swift
//  YouTMusicCore
//
//  Created by Huy Nguyễn on 2/12/18.
//  Copyright © 2018 Huy Nguyen. All rights reserved.
//

import Foundation

public protocol ViewModelCoordinatorProtocol {
    
    var authenViewModel: AuthenticateViewModelProtocol { get }
}

public final class ViewModelCoordinator: ViewModelCoordinatorProtocol {
    
    public let authenViewModel: AuthenticateViewModelProtocol
    
    init(authenViewModel: AuthenticateViewModel) {
        self.authenViewModel = authenViewModel
    }
}
