//
//  LoginUseCase.swift
//  AccountLogin
//
//  Created by Jill Chang on 2022/6/20.
//

import Foundation

public protocol LoginUseCase {
    func signon(param: [String : Any], with completion: @escaping (Result<LoginUserEntity, Error>) -> Void)
}

public final class MainLoginUseCase {
    public let repository: LoginRepository
    
    public init(repository: LoginRepository) {
        self.repository = repository
    }
}

extension MainLoginUseCase: LoginUseCase {
    public func signon(param: [String : Any], with completion: @escaping (Result<LoginUserEntity, Error>) -> Void) {
        self.repository.signon(param: param) { result in
            completion(result)
        }
    }
}
