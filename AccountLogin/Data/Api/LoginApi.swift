//
//  LoginApi.swift
//  AccountLogin
//
//  Created by Jill Chang on 2022/6/23.
//

import Foundation

public struct LoginApi: ApiConfig {
    public let host = "watch-master-staging.herokuapp.com"
    
    public var path = "/api/login"
    
    public let method = HTTPRestfulType.post
    
    public var sessionToken: String? = nil
    
    public var queryParameters: [String : Any]? = nil
    
    public var bodyParamaters: [String : Any]?
}
