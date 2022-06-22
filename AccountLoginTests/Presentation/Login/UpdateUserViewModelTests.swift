//
//  UpdateUserViewModelTests.swift
//  AccountUpdateUserTests
//
//  Created by Jill Chang on 2022/6/22.
//

import XCTest
import AccountLogin

class UpdateUserViewModelTests: XCTestCase {
    func test_errorDataTriggerUpdateUser_failureUpdateUserAlertError() {
        let (sut, usecase) = makeSUT()
        
        let predicateError = failureNSError()
        
        usecase.updateUserResult = .failure(predicateError)
        
        let exp = expectation(description: "Wait for UpdateUser")
        
        sut.output.alertMessage.binding(trigger: false) { newValue, _ in
            guard let msg = newValue else {
                XCTFail("alertMessage is invaild")
                return
            }
            
            XCTAssertEqual(msg.title, "Error")
            XCTAssertEqual(msg.message, predicateError.localizedDescription)
            
            exp.fulfill()
        }
        
        sut.input.updateUserAction(timezone: "8", number: "111", phone: "0900123456")
        
        wait(for: [exp], timeout: 1.0)
    }
    
    func test_correctDataTriggerUpdateUser_successUpdateUserGetUserObject() {
        let (sut, usecase) = makeSUT()
        
        let predicateEntity = UpdateUserEntity(updatedAt: "2022-06-17T08:29:29.513Z")
        
        usecase.updateUserResult = .success(predicateEntity)
        
        let exp = expectation(description: "Wait for UpdateUser")
        
        sut.output.userData.binding(trigger: false) { [weak usecase] newValue, _ in
            guard let entity = newValue else {
                XCTFail("userData is invaild")
                return
            }
            
            XCTAssertEqual(entity.updatedAt, predicateEntity.updatedAt)
            
            XCTAssertEqual(usecase?.updateUserResults.count, 1)
            
            exp.fulfill()
        }
        
        sut.input.updateUserAction(timezone: "8", number: "111", phone: "0900123456")
        
        wait(for: [exp], timeout: 1.0)
    }
    
    
    // MARK: - Helpers
    
    private func makeSUT(file: StaticString = #file, line: UInt = #line) -> (sut: UpdateUserViewModel, usecase: MockUseCase) {
        let usecase = MockUseCase()
        let sut = UpdateUserViewModel(usecase)
        trackForMemoryLeaks(sut, file: file, line: line)
        trackForMemoryLeaks(usecase, file: file, line: line)
        return (sut, usecase)
    }
    
    private func failureNSError() -> NSError {
        return NSError(domain: "any error", code: 0)
    }
    
    private class MockUseCase: UpdateUserUseCase {
        private func failureNSError() -> NSError {
            return NSError(domain: "any error", code: 0)
        }
        
        func updateUser(param: [String : Any], with completion: @escaping (Result<UpdateUserEntity, Error>) -> Void) {
            guard let result = updateUserResult else {
                completion(.failure(failureNSError()))
                return
            }
            self.updateUserResults.append(result)
            completion(result)
        }
        
        var updateUserResult: Result<UpdateUserEntity, Error>?
        var updateUserResults: [Result<UpdateUserEntity, Error>] = []
    }
}
