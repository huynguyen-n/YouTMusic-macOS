//
//  AuthenticateViewModel.swift
//  YouTMusicCore
//
//  Created by Huy Nguyễn on 2/12/18.
//  Copyright © 2018 Huy Nguyen. All rights reserved.
//

import Cocoa
import RxSwift
import OAuthSwift
import RxCocoa

public protocol AuthenticateViewModelProtocol {
    
    var input: AuthenticateViewModelInput { get }
    var output: AuthenticateViewModelOutput { get }
}

public protocol AuthenticateViewModelInput {
    var loginBtnOnTapPublish: PublishSubject<Void> { get }
}

public protocol AuthenticateViewModelOutput {
    var authenticateStateDriver: Driver<AuthenticateState> { get }
}

public final class AuthenticateViewModel: AuthenticateViewModelProtocol, AuthenticateViewModelInput, AuthenticateViewModelOutput {
    
    public var input: AuthenticateViewModelInput { return self }
    public var output: AuthenticateViewModelOutput { return self }
    
    fileprivate let youtMusicOauth = YouTMusicOAuth.shareInstance
    
    public var loginBtnOnTapPublish: PublishSubject<Void> { return YouTMusicOAuth.shareInstance.loginPublisher }
    public var authenticateStateDriver: SharedSequence<DriverSharingStrategy, AuthenticateState>

    public init() {
        let authenticateChanged = YouTMusicOAuth.shareInstance.authenStateObj
        authenticateStateDriver = authenticateChanged.asDriver(onErrorJustReturn: AuthenticateState.unAuthenticated)
    }
}
