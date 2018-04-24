//
//  YouTMusicService.swift
//  YouTMusicCore
//
//  Created by Huy Nguyễn on 3/28/18.
//  Copyright © 2018 Huy Nguyen. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

public final class YouTMusicService  {
    
    
    public init() {
        
    }
    
    public func newestSongsMethodObserver() -> Observable<[SongObj]> {
        return NewestSongsRequest().toObservable()
    }
}

