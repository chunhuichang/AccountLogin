//
//  LoginUserEntity.swift
//  AccountLogin
//
//  Created by Jill Chang on 2022/6/20.
//

import Foundation

public struct LoginUserEntity {
    public init(objectID: String, username: String, code: String, timezone: Int, parameter: Int, number: Int, phone: String, timeZone: String, timone: String, sessionToken: String) {
        self.objectID = objectID
        self.username = username
        self.code = code
        self.timezone = timezone
        self.parameter = parameter
        self.number = number
        self.phone = phone
        self.timeZone = timeZone
        self.timone = timone
        self.sessionToken = sessionToken
    }
    
    public let objectID: String
    public let username: String
    public let code: String
    public let timezone: Int
    public let parameter: Int
    public let number: Int
    public let phone: String
    public let timeZone: String
    public let timone: String
    public let sessionToken: String
}
