//
//  UpdateUserViewModelTests.swift
//  AccountUpdateUserTests
//
//  Created by Jill Chang on 2022/6/22.
//

import XCTest
import AccountLogin

class UpdateUserViewModelTests: XCTestCase {
    func test_initUpdateUser_getUserObject() {
        let (sut, _) = makeSUT()
        
        let predicateEntity = LoginUserEntity(objectID: "objectID", username: "username@qq.com", code: "code", timezone: 20, parameter: 8, number: 5, phone: "0900000000", timeZone: "Asia/Taipei", timone: "10", sessionToken: "r:pnktnjyb996sj4p156gjtp4im")
        
        let exp = expectation(description: "Wait for UpdateUser")
        
        sut.output.userObject.binding(trigger: false) { newValue, _ in
            
            XCTAssertEqual(newValue?.timezone, predicateEntity.timezone)
            XCTAssertEqual(newValue?.number, predicateEntity.number)
            XCTAssertEqual(newValue?.phone, predicateEntity.phone)
            
            exp.fulfill()
        }
        
        sut.userObject.value = predicateEntity
        
        wait(for: [exp], timeout: 1.0)
    }
    
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
        
        sut.output.alertMessage.binding(trigger: false) { newValue, _ in
            guard let msg = newValue else {
                XCTFail("alertMessage is invaild")
                return
            }
            
            XCTAssertEqual(msg.title, "Success")
            XCTAssertEqual(msg.message, "update user info object")
            
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
        
        func updateUser(param: [String : Any], userObject: LoginUserEntity?, with completion: @escaping (Result<UpdateUserEntity, Error>) -> Void) {
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
