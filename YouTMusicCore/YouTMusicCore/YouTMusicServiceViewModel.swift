//
//  NewestSongsViewModel.swift
//  YouTMusicCore
//
//  Created by Huy Nguyễn on 3/29/18.
//  Copyright © 2018 Huy Nguyen. All rights reserved.
//

import Foundation

public protocol YouTMusicServiceViewModel {
    
    var input: YouTMusicServiceViewModelInput { get }
    var output: YouTMusicServiceViewModelOutput { get }
}

public protocol YouTMusicServiceViewModelInput {
    
}

public protocol YouTMusicServiceViewModelOutput {
    
}


public final class YouTMusicServiceViewModel: YouTMusicServiceViewModel, YouTMusicServiceViewModelInput, YouTMusicServiceViewModelOutput {
    
}
