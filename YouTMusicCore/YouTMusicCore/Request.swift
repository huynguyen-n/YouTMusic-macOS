//
//  Request.swift
//  YouTMusicCore
//
//  Created by Huy Nguyễn on 2/8/18.
//  Copyright © 2018 Huy Nguyen. All rights reserved.
//

import Foundation
import Alamofire

public typealias HeaderParameter = [String: String]
public typealias JSONDictionary = [String: Any]

protocol Request: URLRequestConvertible {
    
    associatedtype Element
    
    var basePath: String { get }
    
    var endPoint: String { get }
    
    var method: HTTPMethod { get }
    
    var parameters: Parameters? { get }
    
    var additionalHeader: HeaderParameter? { get }
    
    var isAuthenticate: Bool { get }
    
    func decode(data: Any) throws -> Element?
}
