//
//  LoginRepository.swift
//  AccountLogin
//
//  Created by Jill Chang on 2022/6/20.
//

import Foundation

public protocol LoginRepository {
    func signon(param: [String : Any], with completion: @escaping (Result<LoginUserEntity, Error>) -> Void)
}
