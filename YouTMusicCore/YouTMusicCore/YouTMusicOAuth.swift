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
        
        // Load disk
        loadPersistantUser()
        
        currentUserVariable.asObservable()
            .subscribe(onNext: {[unowned self] (userObj) in
                self.savePersistance(userObj)
            })
            .disposed(by: disposeBag)
        
        loginPublisher.asObserver().flatMapLatest { [unowned self] _ -> Observable<OAuthSwiftCredential?> in
                return self.requestOauthWithGoogle()
            }.subscribe(onNext: { [unowned self] credential in
                guard let credential = credential else { return }
                self.convertToCurrentUser(credential)
            }).disposed(by: disposeBag)
        
        callbackObserverPublich.subscribe(onNext: { (event) in
            if let urlString = event.paramDescriptor(forKeyword: AEKeyword(keyDirectObject))?.stringValue,
                let url = URL(string: urlString) {
                YouTMusicOAuth.applicationHandle(url: url)
            }
        }).disposed(by: disposeBag)
    }
    
    // MARK: - Public
    public func logout() {
        
        // Lock
        lock.lock()
        defer {
            self.lock.unlock()
        }
        
        currentUserVariable.value = nil
    }
    
    public func renewAccessToken() {
        lock.lock()
        defer {
            self.lock.unlock()
        }
        
        loginPublisher.asObserver().flatMapLatest { [unowned self] _ -> Observable<OAuthSwiftCredential?> in
            return self.renewAccessToken()
            }.subscribe (onNext: { [unowned self] credential in
                guard let credential = credential else { return }
                self.convertToCurrentUser(credential)
        }).disposed(by: disposeBag)
    }
    
    fileprivate class func applicationHandle(url: URL) {
        OAuthSwift.handle(url: url)
    }
}

extension YouTMusicOAuth {
    
    fileprivate func lazyOAuthYouTMusic() -> OAuth2Swift {
        return OAuth2Swift(
            consumerKey: Constants.YouTApp.ClientId,
            consumerSecret: Constants.YouTApp.ClientSecret,
            authorizeUrl: Constants.YouTApp.AuthorizeUrl,
            accessTokenUrl: Constants.YouTApp.AccessTokenUrl,
            responseType: Constants.YouTApp.ResponseType )
    }
    
    fileprivate func requestOauthWithGoogle() -> Observable<OAuthSwiftCredential?> {
        return Observable<OAuthSwiftCredential?>.create { [unowned self] (observer) -> Disposable in
            _ = self._youtMusic.authorize(
                withCallbackURL: URL(string: Constants.YouTApp.CallBackUrl)!,
                scope: Constants.YouTApp.ScopeURL,
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
    
    fileprivate func renewAccessToken() -> Observable<OAuthSwiftCredential?> {
        return Observable<OAuthSwiftCredential?>.create { [unowned self] (observer) -> Disposable in
            guard let refreshToken = self.currentUserObj?.authToken.refreshToken else { return Disposables.create() }
            _ = self._youtMusic.renewAccessToken(withRefreshToken: refreshToken, success: { credential, _, _ in
                Logger.debug(credential)
                observer.onNext(credential)
                observer.onCompleted()
            }, failure: { error in
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
        
        if let userObj = userObj {
            storeLock.lock()
            defer {
                self.storeLock.unlock()
            }
            let data = NSKeyedArchiver.archivedData(withRootObject: userObj)
            persistantStore.set(data, forKey: YouTMusicOAuth.PersistantStoreKey)
            persistantStore.synchronize()
        } else {
            storeLock.lock()
            defer {
                self.storeLock.unlock()
            }
            persistantStore.removeObject(forKey: YouTMusicOAuth.PersistantStoreKey)
            persistantStore.synchronize()
        }
    }
    
    public func convertToCurrentUser(_ credential: OAuthSwiftCredential) {
        
        lock.lock()
        defer {
            self.lock.unlock()
        }
        
        let token = OAuthToken(credential: credential)
        let user = UserObj(authToken: token)
        currentUserVariable.value = user
    }
}
