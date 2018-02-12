//
//  NSError.swift
//  YouTMusicCore
//
//  Created by Huy Nguyễn on 2/8/18.
//  Copyright © 2018 Huy Nguyen. All rights reserved.
//

import Foundation

private let ErrorDomain = "com.br.youtmcore.defaultError"

extension NSError {
    
    class func unknowError() -> NSError {
        let userInfo = [NSLocalizedDescriptionKey: "Unknow Error"]
        return NSError(domain: ErrorDomain, code: 999, userInfo: userInfo)
    }
    
    class func jsonMapper() -> NSError {
        let userInfo = [NSLocalizedDescriptionKey: "Json Mapper Error"]
        return NSError(domain: ErrorDomain, code: 998, userInfo: userInfo)
    }
    
    class func youtubeError(data: Any?, code: Int) -> NSError {
        guard let dictData = data as? JSONDictionary else {
            return self.jsonMapper()
        }
        
        return NSError(domain: ErrorDomain, code: code, userInfo: dictData)
    }
}
