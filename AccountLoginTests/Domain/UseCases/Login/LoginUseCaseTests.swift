//
//  LoginUseCaseTests.swift
//  AccountLoginTests
//
//  Created by Jill Chang on 2022/6/19.
//

import XCTest
import AccountLogin

class LoginUseCaseTests: XCTestCase {
    func test_login_deliversError() {
        let (sut, repository) = makeSUT()
        
        let predicateError = failureNSError()
        
        repository.signonResult = .failure(predicateError)
        
        let exp = expectation(description: "Wait for signon")
        
        sut.signon(param: paramData()) { result in
            switch result {
            case .success:
                XCTFail("signon success")
            case .failure(let error):
                XCTAssertEqual(error as NSError, predicateError)
            }
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1.0)
    }
    
    func test_login_deliversEntityOnSuccess() {
        let (sut, repository) = makeSUT()
        
        let predicateEntity = LoginUserEntity(objectID: "objectID", username: "username@qq.com", code: "code", timezone: 20, parameter: 8, number: 5, phone: "0900000000", timeZone: "Asia/Taipei", timone: "10", sessionToken: "r:pnktnjyb996sj4p156gjtp4im")
        
        repository.signonResult = .success(predicateEntity)
        
        let exp = expectation(description: "Wait for signon")
        
        sut.signon(param: paramData()) { result in
            switch result {
            case .success(let entity):
                XCTAssertEqual(entity.objectID, predicateEntity.objectID)
                XCTAssertEqual(entity.username, predicateEntity.username)
                XCTAssertEqual(entity.timezone, predicateEntity.timezone)
                XCTAssertEqual(entity.parameter, predicateEntity.parameter)
                XCTAssertEqual(entity.number, predicateEntity.number)
                XCTAssertEqual(entity.phone, predicateEntity.phone)
                XCTAssertEqual(entity.timeZone, predicateEntity.timeZone)
                XCTAssertEqual(entity.timone, predicateEntity.timone)
                XCTAssertEqual(entity.sessionToken, predicateEntity.sessionToken)
            case .failure:
                XCTFail("signon failure")
            }
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1.0)
    }
    
    // MARK: - Helpers
    
    private func makeSUT(file: StaticString = #file, line: UInt = #line) -> (sut: MainLoginUseCase, repository: MockRepository) {
        let repository = MockRepository()
        let sut = MainLoginUseCase(repository: repository)
        trackForMemoryLeaks(sut, file: file, line: line)
        trackForMemoryLeaks(repository, file: file, line: line)
        return (sut, repository)
    }
    
    private func paramData() -> [String : Any] {
        return ["username": "user1", "password":"password1"]
    }
    
    private func failureNSError() -> NSError {
        return NSError(domain: "any error", code: 0)
    }
    
    private final class MockRepository: LoginRepository {
        private func failureNSError() -> NSError {
            return NSError(domain: "any error", code: 0)
        }
        
        func signon(param: [String : Any], with completion: @escaping (Result<LoginUserEntity, Error>) -> Void) {
            guard let result = signonResult else {
                completion(.failure(failureNSError()))
                return
            }
            completion(result)
        }
        
        var signonResult: Result<LoginUserEntity, Error>?
    }
}
