//
//  ThumbnailObj.swift
//  YouTMusicCore
//
//  Created by Huy Nguyễn on 3/27/18.
//  Copyright © 2018 Huy Nguyen. All rights reserved.
//

import Cocoa
import Unbox

public class BaseThumbnailObj: Unboxable {
    
    public private(set) var url: String
    public private(set) var width: Int
    public private(set) var height: Int
    
    public required init(unboxer: Unboxer) throws {
        url = try unboxer.unbox(key: Constants.Obj.Thumbnail.Url)
        width = try unboxer.unbox(key: Constants.Obj.Thumbnail.Width)
        height = try unboxer.unbox(key: Constants.Obj.Thumbnail.Height)
    }
}

public final class ThumbnailObj: Unboxable {
    
    public private(set) var _default: BaseThumbnailObj
    public private(set) var medium: BaseThumbnailObj?
    public private(set) var hight: BaseThumbnailObj?
    public private(set) var standard: BaseThumbnailObj?
    public private(set) var maxres: BaseThumbnailObj?
    
    public init(unboxer: Unboxer) throws {
        _default = try unboxer.unbox(key: Constants.Obj.Thumbnail.Default)
        medium = unboxer.unbox(key: Constants.Obj.Thumbnail.Medium)
        hight = unboxer.unbox(key: Constants.Obj.Thumbnail.Height)
        standard = unboxer.unbox(key: Constants.Obj.Thumbnail.Standard)
        maxres = unboxer.unbox(key: Constants.Obj.Thumbnail.Maxres)
    }
}
