//
//  UpdateUserMockRepository.swift
//  AccountLogin
//
//  Created by Jill Chang on 2022/6/22.
//

import Foundation

final class UpdateUserMockRepository: UpdateUserRepository {
    func updateUser(param: [String : Any], userObject: LoginUserEntity? = nil, with completion: @escaping (Result<UpdateUserEntity, Error>) -> Void) {
        guard let entity = self.updateUserEntity else {
            completion(.failure(NSError(domain: "Error", code: 0)))
            return
        }
        completion(.success(entity))
    }
    
    public var updateUserEntity: UpdateUserEntity?
    
    init() {
        updateUserEntity = UpdateUserEntity(updatedAt: "2022-06-17T08:29:29.513Z")
    }
}
