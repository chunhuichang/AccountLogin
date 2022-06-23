//
//  MainUpdateUserRepository.swift
//  AccountLogin
//
//  Created by Jill Chang on 2022/6/23.
//

import Foundation

public final class MainUpdateUserRepository: UpdateUserRepository {
    private let loadDataLoader: DataServiceLoader
    
    public init(loadDataLoader: DataServiceLoader) {
        self.loadDataLoader = loadDataLoader
    }
    
    public func updateUser(param: [String : Any], userObject: LoginUserEntity? = nil, with completion: @escaping (Result<UpdateUserEntity, Error>) -> Void) {
        let objectID = userObject?.objectID ?? ""
        let sessionToken = userObject?.sessionToken ?? ""
        let api = UpdateUserApi(path: "/api/users/\(objectID)", sessionToken: sessionToken, bodyParamaters: param)
        
        self.loadDataLoader.load(type: UpdateUserDTO.self, config: api) { result in
            switch(result) {
            case .success(let repositoryDTO) :
                completion(.success(repositoryDTO.toDomain()))
                
            case .failure(let error) :
                completion(.failure(error))
            }
        }
    }
}
