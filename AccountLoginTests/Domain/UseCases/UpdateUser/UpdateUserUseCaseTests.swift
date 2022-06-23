//
//  UpdateUserUseCaseTests.swift
//  AccountLoginTests
//
//  Created by Jill Chang on 2022/6/22.
//

import XCTest
import AccountLogin

class UpdateUserUseCaseTests: XCTestCase {
    func test_updateUser_deliversError() {
        let (sut, repository) = makeSUT()
        
        let predicateError = failureNSError()
        
        repository.updateUserResult = .failure(predicateError)
        
        let exp = expectation(description: "Wait for update user ")
        
        sut.updateUser(param: paramData()) { result in
            switch result {
            case .success:
                XCTFail("update user  success")
            case .failure(let error):
                XCTAssertEqual(error as NSError, predicateError)
            }
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1.0)
    }
    
    func test_updateUser_deliversEntityOnSuccess() {
        let (sut, repository) = makeSUT()
        
        let predicateEntity = UpdateUserEntity(updatedAt: "2022-06-17T08:29:29.513Z")
        
        repository.updateUserResult = .success(predicateEntity)
        
        let exp = expectation(description: "Wait for update user")
        
        sut.updateUser(param: paramData()) { result in
            switch result {
            case .success(let entity):
                XCTAssertEqual(entity.updatedAt, predicateEntity.updatedAt)
            case .failure:
                XCTFail("update user failure")
            }
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1.0)
    }
    
    // MARK: - Helpers
    
    private func makeSUT(file: StaticString = #file, line: UInt = #line) -> (sut: MainUpdateUserUseCase, repository: MockRepository) {
        let repository = MockRepository()
        let sut = MainUpdateUserUseCase(repository: repository)
        trackForMemoryLeaks(sut, file: file, line: line)
        trackForMemoryLeaks(repository, file: file, line: line)
        return (sut, repository)
    }
    
    private func paramData() -> [String : Any] {
        return ["timezone": 8, "number": 123, "phone": "0911111111"]
    }
    
    private func failureNSError() -> NSError {
        return NSError(domain: "any error", code: 0)
    }
    
    private final class MockRepository: UpdateUserRepository {
        private func failureNSError() -> NSError {
            return NSError(domain: "any error", code: 0)
        }
        
        func updateUser(param: [String : Any], userObject: LoginUserEntity?, with completion: @escaping (Result<UpdateUserEntity, Error>) -> Void) {
            guard let result = updateUserResult else {
                completion(.failure(failureNSError()))
                return
            }
            completion(result)
        }
        
        var updateUserResult: Result<UpdateUserEntity, Error>?
    }
}
