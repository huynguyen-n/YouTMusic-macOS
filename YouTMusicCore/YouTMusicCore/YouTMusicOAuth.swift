//
//  YouTMusicOAuth.swift
//  YouTMusicCore
//
//  Created by Huy Nguyễn on 2/9/18.
//  Copyright © 2018 Huy Nguyen. All rights reserved.
//

import Foundation
import OAuthSwift
import RxSwift

public final class YouTMusicOAuth {
    
    public var callbackObserverPublich = PublishSubject<NSAppleEventDescriptor>()
    public var loginPublisher = PublishSubject<Void>()
    fileprivate lazy var _youtMusic: OAuth2Swift = self.lazyOAuthYouTMusic()
    fileprivate lazy var disposeBag = DisposeBag()
    
    public static let shareInstance = YouTMusicOAuth()
    
    fileprivate let persistantStore = UserDefaults.standard
    fileprivate static let PersistantStoreKey = "YouTMusic.CurrentUser"
    
    public fileprivate(set) var currentUserVariable = Variable<UserObj?>(nil)
    public var currentUserObj: UserObj? { return currentUserVariable.value }
    public var authenStateObj: Observable<AuthenticateState>
    
    fileprivate let lock = NSLock()
    fileprivate let storeLock = NSLock()
    
    public init() {
        
        authenStateObj = currentUserVariable.asObservable()
            .map { $0 == nil ? .unAuthenticated : .authenticated }
            .distinctUntilChanged()
    }
}

extension YouTMusicOAuth {
    
    fileprivate func lazyOAuthYouTMusic() -> OAuth2Swift {
        return OAuth2Swift(
            consumerKey: Constants.YouTApp.ApiKey,
            consumerSecret: "",
            authorizeUrl: Constants.YouTApp.AuthorizeUrl,
            accessTokenUrl: Constants.YouTApp.AccessTokenUrl,
            responseType: Constants.YouTApp.ResponseType )
    }
    
    fileprivate func requestOauthWithGoogle() -> Observable<OAuthSwiftCredential?> {
        return Observable<OAuthSwiftCredential?>.create { [unowned self] (observer) -> Disposable in
            _ = self._youtMusic.authorize(
                withCallbackURL: URL(string: Constants.YouTApp.CallBackUrl)!,
                scope: "",
                state: "YOUTMUSIC",
                success: { credential, _, _ in
                    Logger.debug(credential.oauthToken)
                    observer.onNext(credential)
                    observer.onCompleted()
            },
                failure: { error in
                    Logger.error(error)
                    observer.onNext(nil)
                    observer.onCompleted()
            })
            
            return Disposables.create()
        }
    }
}

extension YouTMusicOAuth {
    
    fileprivate func loadPersistantUser() {
        
        self.lock.lock()
        defer {
            self.lock.unlock()
        }
        
        guard let data = UserDefaults.standard.data(forKey: YouTMusicOAuth.PersistantStoreKey) else { return }
        guard let userObj = NSKeyedUnarchiver.unarchiveObject(with: data) as? UserObj else { return }
        currentUserVariable.value = userObj
    }
    
    fileprivate func savePersistance(_ userObj: UserObj?) {
        storeLock.lock()
        defer {
            self.storeLock.lock()
        }
        if let userObj = userObj {
            
            let data = NSKeyedArchiver.archivedData(withRootObject: userObj)
            persistantStore.set(data, forKey: YouTMusicOAuth.PersistantStoreKey)
            persistantStore.synchronize()
        } else {
            persistantStore.removeObject(forKey: YouTMusicOAuth.PersistantStoreKey)
            persistantStore.synchronize()
        }
    }
    
    public func convertToCurrentUser(_ credential: OAuthSwiftCredential) {
        
        lock.lock()
        defer {
            self.lock.lock()
        }
        
        let token = OAuthToken(credential: credential)
        let user = UserObj(authToken: token)
        currentUserVariable.value = user
    }
}
