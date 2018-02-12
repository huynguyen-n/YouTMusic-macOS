//
//  Request + Alamofire.swift
//  YouTMusicCore
//
//  Created by Huy Nguyễn on 2/8/18.
//  Copyright © 2018 Huy Nguyen. All rights reserved.
//

import Foundation
import Alamofire

extension Request {
    func asURLRequest() throws -> URLRequest {
        return self.buildURLRequest()
    }
}

extension Request {
    
    fileprivate func buildURLRequest() -> URLRequest {
        var request = URLRequest(url: self.url)
        request.httpMethod = method.rawValue
        request.timeoutInterval = TimeInterval(10 * 1000)
        
        guard var finalRequest = try? self.parameterEncoding.encode(request, with: self.parameters) else {
            fatalError("Can not handle unknow error")
        }
        
        if let additionalHeader = self.additionalHeader {
            additionalHeader.forEach {
                finalRequest.addValue($0.value, forHTTPHeaderField: $0.key)
            }
        }
        
        if isAuthenticate {
            let currentUser = YouTMusicOAuth.shareInstance.currentUserObj!
            currentUser.authToken.setAuthenticationHeader(request: &finalRequest)
        }
        
        return finalRequest
    }
}
