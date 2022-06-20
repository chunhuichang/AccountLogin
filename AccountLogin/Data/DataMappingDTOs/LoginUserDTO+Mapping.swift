//
//  LoginUserDTO+Mapping.swift
//  AccountLogin
//
//  Created by Jill Chang on 2022/6/20.
//

import Foundation

public struct LoginUserDTO {
    let objectID: String
    let userName: String
    let code: String
    let isVerifiedReportEmail: Bool
    let reportEmail: String
    let createdAt: String
    let updatedAt: String
    let timezone: Int
    let parameter: Int
    let number: Int
    let phone: String
    let timeZone: String
    let timone: String
    let sessionToken: String
}

extension LoginUserDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case objectID = "objectId"
        case userName = "username"
        case code, isVerifiedReportEmail, reportEmail, createdAt, updatedAt, timezone, parameter, number, phone, timeZone, timone, sessionToken
    }
}

extension LoginUserDTO {
    public func toDomain() -> LoginUserEntity {
        return LoginUserEntity(objectID: objectID, username: userName, code: code, timezone: timezone, parameter: parameter, number: number, phone: phone, timeZone: timeZone, timone: timone, sessionToken: sessionToken)
    }
}
