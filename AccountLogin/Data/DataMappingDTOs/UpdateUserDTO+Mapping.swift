//
//  UpdateUserDTO+Mapping.swift
//  AccountLogin
//
//  Created by Jill Chang on 2022/6/22.
//

import Foundation

public struct UpdateUserDTO {
    let updatedAt: String
    let role: Role
    
    struct Role {
        let op: String
    }
}

extension UpdateUserDTO: Decodable {}

extension UpdateUserDTO.Role: Decodable {
    private enum CodingKeys: String, CodingKey {
        case op = "__op"
    }
}

extension UpdateUserDTO {
    public func toDomain() -> UpdateUserEntity {
        return UpdateUserEntity(updatedAt: updatedAt)
    }
}
