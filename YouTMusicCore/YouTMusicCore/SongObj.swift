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
    public private(set) var singer: String
//    public private(set) var thumbnail: ThumbnailObj
    public private(set) var audioUrl: String
    
    public required init(unboxer: Unboxer) throws {
        let snippetDict = unboxer.dictionary["snippet"] as? [String: Any]
        
        title = (snippetDict?[Constants.Obj.Song.Title] as? String) ?? ""
//        thumbnail = snippetDict?[Constants.Obj.Song.Thumbnails] as ThumbnailObj
        audioUrl = (snippetDict?[Constants.Obj.Song.AudioUrl] as? String) ?? ""
        singer = (snippetDict?[Constants.Obj.Song.Singer] as? String) ?? ""
    }
}

