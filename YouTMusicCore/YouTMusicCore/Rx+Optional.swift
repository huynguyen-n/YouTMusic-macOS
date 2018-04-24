//
//  Rx+Optional.swift
//  YouTMusicCore
//
//  Created by Huy Nguyễn on 4/2/18.
//  Copyright © 2018 Huy Nguyen. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

public protocol OptionalType {
    associatedtype Wrapped
    var value: Wrapped? { get }
}

extension Optional: OptionalType {
    
    public var value: Wrapped? {
        return self
    }
}

public extension ObservableType where E: OptionalType {
    
    public func filterNil() -> Observable<E.Wrapped> {
        return self.flatMap { element -> Observable<E.Wrapped> in
            guard let value = element.value else {
                return Observable<E.Wrapped>.empty()
            }
            return Observable<E.Wrapped>.just(value)
        }
    }
}
