//
//  MainLoginRepository.swift
//  AccountLogin
//
//  Created by Jill Chang on 2022/6/23.
//

import Foundation

public final class MainLoginRepository: LoginRepository {
    
    private let loadDataLoader: DataServiceLoader

    public init(loadDataLoader: DataServiceLoader) {
        self.loadDataLoader = loadDataLoader
    }
    
    public func signon(param: [String : Any], with completion: @escaping (Result<LoginUserEntity, Error>) -> Void) {
        let api = LoginApi(bodyParamaters: param)
        self.loadDataLoader.load(type: LoginUserDTO.self, config: api) { result in
            switch(result) {
            case .success(let repositoryDTO) :
                completion(Result.success(repositoryDTO.toDomain()))
                
            case .failure(let error) :
                completion(Result.failure(error))
            }
        }
    }
}
