//
//  OAuthToken.swift
//  YouTMusicCore
//
//  Created by Huy Nguyễn on 2/9/18.
//  Copyright © 2018 Huy Nguyen. All rights reserved.
//

import Foundation
import OAuthSwift

public class OAuthToken: NSObject, NSCoding {
    
    
    public var token: String
    public var refreshToken: String
    public var tokenExpires: Date?
    
    
    init(token: String, refreshToken: String, tokenExpires: Date?) {
        self.token = token
        self.refreshToken = refreshToken
        self.tokenExpires = tokenExpires
    }
    
    public init(credential: OAuthSwiftCredential) {
        self.token = credential.oauthToken
        self.refreshToken = credential.oauthRefreshToken
        self.tokenExpires = credential.oauthTokenExpiresAt
    }
    
    
    public func setAuthenticationHeader(request: inout URLRequest) {
        let tokenStr = "Bearer " + self.token
        request.setValue(tokenStr, forHTTPHeaderField: "Authorization")
    }
    
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(self.token, forKey: Constants.Obj.Auth.OauthToken)
        aCoder.encode(self.refreshToken, forKey: Constants.Obj.Auth.OauthRefreshToken)
        aCoder.encode(self.tokenExpires, forKey: Constants.Obj.Auth.OauthTokenExpiresAt)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        self.token = aDecoder.decodeObject(forKey: Constants.Obj.Auth.OauthToken) as! String
        self.refreshToken = aDecoder.decodeObject(forKey: Constants.Obj.Auth.OauthRefreshToken) as! String
        self.tokenExpires = aDecoder.decodeObject(forKey: Constants.Obj.Auth.OauthTokenExpiresAt) as? Date
    }
}
