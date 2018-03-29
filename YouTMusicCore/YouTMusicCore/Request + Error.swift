//
//  Request + Error.swift
//  YouTMusicCore
//
//  Created by Huy Nguyễn on 2/8/18.
//  Copyright © 2018 Huy Nguyen. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

extension Request {
    
    func handleValidation(_ response: DataResponse<Any>?) -> NSError? {
        
        guard let innerResponse = response?.response else {
            return NSError.jsonMapper()
        }
        
        let statusCode = innerResponse.statusCode
        
        if 200...300 ~= statusCode {
            return  nil
        }
        
        return NSError.youtubeError(data: innerResponse.allHeaderFields, code: statusCode)
    }
}
