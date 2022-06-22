//
//  UpdateUserEntity.swift
//  AccountLogin
//
//  Created by Jill Chang on 2022/6/22.
//

import Foundation

public struct UpdateUserEntity {
    public init(updatedAt: String) {
        self.updatedAt = updatedAt
    }   
    
    public let updatedAt: String
}
