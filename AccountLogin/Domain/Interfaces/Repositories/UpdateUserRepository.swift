//
//  UpdateUserRepository.swift
//  AccountLogin
//
//  Created by Jill Chang on 2022/6/22.
//

import Foundation

public protocol UpdateUserRepository {
    func updateUser(param: [String : Any], userObject: LoginUserEntity?, with completion: @escaping (Result<UpdateUserEntity, Error>) -> Void)
}
