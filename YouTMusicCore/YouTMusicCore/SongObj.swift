//
//  SongObjs.swift
//  YouTMusicCore
//
//  Created by Huy Nguyễn on 2/8/18.
//  Copyright © 2018 Huy Nguyen. All rights reserved.
//

import Foundation
import Unbox

public final class SongObj: Unboxable {
    
    public private(set) var title: String
//    public private(set) var singer: String
    public private(set) var thumbnail: ThumbnailObj
//    public private(set) var audioUrl: String
    
    public required init(unboxer: Unboxer) throws {
        
        title = try unboxer.unbox(keyPath: "snippet.title")
        thumbnail = try unboxer.unbox(keyPath: "snippet.thumbnails")
//        audioUrl = try unboxer.unbox(keyPath: "snippet.AudioUrl")
//        singer = try unboxer.unbox(keyPath: "snippet.singer")
    }
}

