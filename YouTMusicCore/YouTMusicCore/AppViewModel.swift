//
//  AppViewModels.swift
//  YouTMusicCore
//
//  Created by Huy Nguyễn on 2/13/18.
//  Copyright © 2018 Huy Nguyen. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

public enum PopoverState {
    case open, close
}

public protocol AppViewModelProtocol {
    var input: AppViewModelInput { get }
    var output: AppViewModelOutput { get }
}

public protocol AppViewModelInput {
    
    var switchPopoverPublish: PublishSubject<Void> { get }
    var actionPopoverPublish: PublishSubject<PopoverState> { get }
}

public protocol AppViewModelOutput {
    
    var popoverStateVariable: Variable<PopoverState> { get }
}

public final class AppViewModel: AppViewModelProtocol, AppViewModelInput, AppViewModelOutput {
    
    public var input: AppViewModelInput { return self }
    public var output: AppViewModelOutput { return self }
    
    public var switchPopoverPublish = PublishSubject<Void>()
    
    public var actionPopoverPublish = PublishSubject<PopoverState>()
    
    public var popoverStateVariable = Variable<PopoverState>(.close)
    
    fileprivate let disposeBag = DisposeBag()
}
