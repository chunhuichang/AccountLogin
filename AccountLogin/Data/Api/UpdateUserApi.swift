//
//  UpdateUserApi.swift
//  AccountLogin
//
//  Created by Jill Chang on 2022/6/24.
//

import Foundation

public struct UpdateUserApi: ApiConfig {
    public let host = "watch-master-staging.herokuapp.com"
    
    public var path = "/api/users/"
    
    public let method = HTTPRestfulType.put
    
    public var sessionToken: String?
    
    public var queryParameters: [String : Any]? = nil
    
    public var bodyParamaters: [String : Any]?
}
