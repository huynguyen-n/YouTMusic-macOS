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
    
    public var url: String?
    public var thumbnail: String?
    public var name: String?
    
    
    public init(unboxer: Unboxer) throws {
        
    }
}
