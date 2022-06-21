//
//  LoginMockRepository.swift
//  AccountLogin
//
//  Created by Jill Chang on 2022/6/21.
//

import Foundation

final class LoginMockRepository: LoginRepository {
    func signon(param: [String : Any], with completion: @escaping (Result<LoginUserEntity, Error>) -> Void) {
        guard let entity = self.loginUserEntity else {
            completion(.failure(NSError(domain: "Error", code: 0)))
            return
        }
        completion(.success(entity))    }
    
    public var loginUserEntity: LoginUserEntity?
    
    init() {
        loginUserEntity = LoginUserEntity(objectID: "objectID", username: "username@qq.com", code: "code", timezone: 20, parameter: 8, number: 5, phone: "0900000000", timeZone: "Asia/Taipei", timone: "10", sessionToken: "r:pnktnjyb996sj4p156gjtp4im")
    }
}
