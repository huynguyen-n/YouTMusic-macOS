//
//  Request + Default.swift
//  YouTMusicCore
//
//  Created by Huy Nguyễn on 2/8/18.
//  Copyright © 2018 Huy Nguyen. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

extension Request {
    
    var basePath: String { return Constants.YouTAPI.BaseURL }
    
    var parameters: Parameters? { return nil }
    
    var additionalHeader: HeaderParameter? { return nil }
    
    var defaultHeader: HeaderParameter? { return ["Accept": "application/json", "Accept-Language": "en_US"] }
    
    var isAuthenticate: Bool { return false }
    
    var urlPath: String { return basePath + endPoint }
    
    var url: URL { return URL(string: urlPath)! }
    
    var parameterEncoding: ParameterEncoding {
        if self.method == .get {
            return URLEncoding.default
        }
        return JSONEncoding.default
    }
    
    func toObservable() -> Observable<Element> {
        
        return Observable<Element>.create({ (observer) -> Disposable in
            guard let urlRequest = try? self.asURLRequest() else {
                observer.onError(NSError.unknowError())
                return Disposables.create()
            }
            
            Alamofire
                .request(urlRequest)
                .validate(contentType: ["application/json", "text/html" ])
                .responseJSON(completionHandler: { (response) in
                    
                    if let error = self.validationResponse(response) {
                        Logger.error("[ERROR API] = \(self.endPoint) = \(error)")
                        observer.onError(error)
                        return
                    }
                    
                    do {
                        guard let result = try self.decode(data: response.result.value!) else {
                            observer.onNext(() as! Element)
                            return
                        }
                        
                        Logger.info(result)
                        observer.onNext(result)
                    } catch let error {
                        Logger.error("[JSON MAPPER] = \(self.endPoint) = \(error)")
                        observer.onError(error)
                    }
                    
                    observer.onCompleted()
                    return
            })
            
            return Disposables.create()
        })
    }
}
