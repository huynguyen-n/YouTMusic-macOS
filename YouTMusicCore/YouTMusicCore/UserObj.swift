//
//  UserObj.swift
//  YouTMusicCore
//
//  Created by Huy Nguyễn on 2/9/18.
//  Copyright © 2018 Huy Nguyen. All rights reserved.
//

import Foundation
import Unbox

public class UserObj: NSObject, NSCoding {
    
    public var name: String?
    public var authToken: OAuthToken
    
    public init(authToken: OAuthToken) {
        self.authToken = authToken
        super.init()
    }
    
    public required init(unboxer: Unboxer) throws {
        name = unboxer.unbox(key: Constants.Obj.User.Name)
        authToken = OAuthToken(token: try unboxer.unbox(key: "access_token"),
                               refreshToken: try unboxer.unbox(key: "refresh_token"),
                               tokenExpires: unboxer.unbox(key: "expires_in", formatter: DateFormatter()) )
    }
    
    public func encode(with aCoder: NSCoder) {
        _ = aCoder.decodeObject(forKey: Constants.Obj.User.Name)
        _ = aCoder.decodeObject(forKey: Constants.Obj.User.Auth)
    }
    
    @objc required public init?(coder aDecoder: NSCoder) {
        self.name = aDecoder.decodeObject(forKey: Constants.Obj.User.Name) as? String
        self.authToken = aDecoder.decodeObject(forKey: Constants.Obj.User.Auth) as! OAuthToken
        super.init()
    }
}
