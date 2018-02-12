//
//  Constants.swift
//  YouTMusicCore
//
//  Created by Huy Nguyễn on 2/8/18.
//  Copyright © 2018 Huy Nguyen. All rights reserved.
//

import Foundation

struct Constants {
    
    struct YouTApp {
        
        static let ApiKey = "AIzaSyCvax7lzO32e-C8_WfwCxd8hi0fKUjaEt0"
        static let ClientId = "993599062458-t0n1r0e5gg3a1b63hvt4htl1ccjm0ej4.apps.googleusercontent.com"
        static let AuthorizeUrl = "https://accounts.google.com/o/oauth2/auth"
        static let AccessTokenUrl = "https://accounts.google.com/o/oauth2/token"
        static let ResponseType = "code"
        static let CallBackUrl = "oauth-youtmusic://oauth-callback/youtmusic"
    }
    
    struct YouTAPI {
        
        // TODO:- Update if have the production or staging server URL
        static let BaseURL = "https://www.googleapis.com/youtube/v3"
        
        static let SongDetail = "/:id"
    }
    
    struct Obj {
        
        struct Auth {
            static let OauthToken = "oauthToken"
            static let OauthRefreshToken = "oauthRefreshToken"
            static let OauthTokenExpiresAt = "oauthTokenExpiresAt"
        }
        
        struct User {
            static let Name = "name"
            static let Auth = "auth"
        }
    }
}
