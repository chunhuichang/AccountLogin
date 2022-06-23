//
//  ApiConfig.swift
//  AccountLogin
//
//  Created by Jill Chang on 2022/6/23.
//

import Foundation

public enum HTTPRestfulType: String {
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
}

public protocol ApiConfig {
    var host: String { get }
    var path: String { get set }
    var method: HTTPRestfulType { get }
    var sessionToken: String? { get set }
    var queryParameters: [String: Any]? { get set }
    var bodyParamaters: [String: Any]? { get set }
}
