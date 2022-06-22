//
//  UpdateUserUseCase.swift
//  AccountLogin
//
//  Created by Jill Chang on 2022/6/22.
//

import Foundation

public protocol UpdateUserUseCase {
    func updateUser(param: [String : Any], with completion: @escaping (Result<UpdateUserEntity, Error>) -> Void)
}

public final class MainUpdateUserUseCase {
    public let repository: UpdateUserRepository
    
    public init(repository: UpdateUserRepository) {
        self.repository = repository
    }
}

extension MainUpdateUserUseCase: UpdateUserUseCase {
    public func updateUser(param: [String : Any], with completion: @escaping (Result<UpdateUserEntity, Error>) -> Void) {
        self.repository.updateUser(param: param) { result in
            completion(result)
        }
    }
}
