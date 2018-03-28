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
        
        static let ClientId = "993599062458-o9aajlcin7vfjkqv30i6365ja57ojlhq.apps.googleusercontent.com"
        static let ClientSecret = "aIblqyqn7FJE8v7fvalGfV1R"
        static let AuthorizeUrl = "https://accounts.google.com/o/oauth2/auth"
        static let AccessTokenUrl = "https://accounts.google.com/o/oauth2/token"
        static let ResponseType = "code"
        static let CallBackUrl = "com.googleusercontent.apps.993599062458-o9aajlcin7vfjkqv30i6365ja57ojlhq:/oauthredirect"
        static let ScopeURL = "https://www.googleapis.com/auth/youtube"
    }
    
    struct YouTAPI {
        
        // TODO:- Update if have the production or staging server URL
        static let BaseURL = "https://www.googleapis.com/youtube/v3"
        
        static let SongDetail = "/:id"
        
        static let NewestSongs = "/search?part=snippet&order=date&type=video&videoCategoryId=10"
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
        
        struct Thumbnail {
            static let Url = "url"
            static let Width = "width"
            static let Height = "height"
            static let Default = "default"
            static let Medium = "medium"
            static let Hight = "hight"
            static let Standard = "standard"
            static let Maxres = "maxres"
        }
        
        struct Song {
            static let Title = "title"
            static let Thumbnails = "thumbnails"
            static let AudioUrl = "audio_url"
            static let Singer = "singer"
        }
    }
}
