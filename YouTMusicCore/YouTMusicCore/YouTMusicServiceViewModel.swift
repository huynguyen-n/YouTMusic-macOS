//
//  NewestSongsViewModel.swift
//  YouTMusicCore
//
//  Created by Huy Nguyễn on 3/29/18.
//  Copyright © 2018 Huy Nguyen. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

public protocol YouTMusicServiceViewModelProtocol {
    
    var input: YouTMusicServiceViewModelInput { get }
    var output: YouTMusicServiceViewModelOutput { get }
}

public protocol YouTMusicServiceViewModelInput {
    
}

public protocol YouTMusicServiceViewModelOutput {
    
}


public final class YouTMusicServiceViewModel: YouTMusicServiceViewModelProtocol,
                                                YouTMusicServiceViewModelInput,
YouTMusicServiceViewModelOutput {
    
    //    MARK: - Input
    // TODO
    
    //    MARK: - Output
    // TODO
    
    //    MARK: - View Model
    public var input: YouTMusicServiceViewModelInput { return self }
    public var output: YouTMusicServiceViewModelOutput { return self }
    
    //    MARK: - Variable
    fileprivate var youtmService: YouTMusicService
    
    //    Dispose
    fileprivate let disposeBag = DisposeBag()
    
    //    MARK: - Init
    init(youtmService: YouTMusicService) {
        
        self.youtmService = youtmService
        
        YouTMusicOAuth.shareInstance.currentUserObj?.reloadYouTMusicDataPublisher.onNext(())
    }
}
