//
//  APIResult.swift
//  YouTMusicCore
//
//  Created by Huy Nguyễn on 4/2/18.
//  Copyright © 2018 Huy Nguyen. All rights reserved.
//

import Foundation

public enum APIResult<T>: RawRepresentable {
    
    public typealias RawValue = T
    
    //    Case
    case success(T)
    case error(NSError)
    
    public init?(rawValue: T) {
        self = .success(rawValue)
    }
    
    public init(errorValue: NSError) {
        self = .error(errorValue as NSError)
    }
    
    public var rawValue: T {
        switch self {
        case .success(let data):
            return data
        default:
            // There is no way return ERROR which corresponse with <T>
            fatalError("There is no way return ERROR which corresponse with <T>")
        }
    }
    
    //    MARK: - Public
    public var isSuccess: Bool {
        switch self {
        case .success:
            return true
        default:
            return false
        }
    }
    
    public var isError: Bool {
        switch self {
        case .error:
            return true
        default:
            return false
        }
    }
    
    public var result: T? {
        switch self {
        case .success(let data):
            return data
        default:
            return nil
        }
    }
    
    public var error: NSError? {
        switch self {
        case .error(let error):
            return error
        default:
            return nil
        }
    }
}
