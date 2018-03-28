//
//  NewestSongsRequest.swift
//  YouTMusicCore
//
//  Created by Huy Nguyễn on 3/28/18.
//  Copyright © 2018 Huy Nguyen. All rights reserved.
//

import Foundation
import Alamofire
import Unbox

final class NewestSongsRequest: Request {
    
    typealias Element = Array<SongObj>
    
    var endPoint: String { return Constants.YouTAPI.NewestSongs}
    
    var method: HTTPMethod { return .get }
    
    var parameters: Parameters? { return nil }
    
    func decode(data: Any) throws -> Element? {
        guard let result = data as? [String: Any] else {
            return nil
        }
        return try unbox(dictionary: result, atKey: "items")
    }
}
