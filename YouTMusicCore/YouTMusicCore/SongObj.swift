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
    public private(set) var thumbnail: ThumbnailObj
    public private(set) var audioUrl: String

    public required init(unboxer: Unboxer) throws {
        title = try unboxer.unbox(key: Constants.Obj.Song.Title)
        thumbnail = try unboxer.unbox(key: Constants.Obj.Song.Thumbnails)
        audioUrl = try unboxer.unbox(key: Constants.Obj.Song.AudioUrl)
        singer = try unboxer.unbox(key: Constants.Obj.Song.Singer)
    }
}

