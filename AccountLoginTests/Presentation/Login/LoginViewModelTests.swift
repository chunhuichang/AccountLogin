//
//  LoginViewModelTests.swift
//  AccountLoginTests
//
//  Created by Jill Chang on 2022/6/20.
//

import XCTest
import AccountLogin

class LoginViewModelTests: XCTestCase {
    func test_errorDataTriggerlogin_failureLoginAlertError() {
        let (sut, usecase) = makeSUT()
        
        let predicateError = failureNSError()
        
        usecase.signonResult = .failure(predicateError)
        
        let exp = expectation(description: "Wait for login")
        
        sut.output.alertMessage.binding(trigger: false) { newValue, _ in
            guard let msg = newValue else {
                XCTFail("alertMessage is invaild")
                return
            }
            
            XCTAssertEqual(msg.title, "Error")
            XCTAssertEqual(msg.message, predicateError.localizedDescription)
            
            exp.fulfill()
        }
        
        sut.input.loginTrigger.value = ("username","password")
        
        wait(for: [exp], timeout: 1.0)
    }
    
    func test_correctDataTriggerlogin_successLoginGetUserObject() {
        let (sut, usecase) = makeSUT()
        
        let predicateEntity = LoginUserEntity(objectID: "objectID", username: "username@qq.com", code: "code", timezone: 20, parameter: 8, number: 5, phone: "0900000000", timeZone: "Asia/Taipei", timone: "10", sessionToken: "r:pnktnjyb996sj4p156gjtp4im")
        
        usecase.signonResult = .success(predicateEntity)
        
        let exp = expectation(description: "Wait for login")
        
        sut.output.userData.binding(trigger: false) { [weak usecase] newValue, _ in
            guard let entity = newValue else {
                XCTFail("userData is invaild")
                return
            }
            
            XCTAssertEqual(entity.objectID, predicateEntity.objectID)
            XCTAssertEqual(entity.username, predicateEntity.username)
            XCTAssertEqual(entity.timezone, predicateEntity.timezone)
            XCTAssertEqual(entity.parameter, predicateEntity.parameter)
            XCTAssertEqual(entity.number, predicateEntity.number)
            XCTAssertEqual(entity.phone, predicateEntity.phone)
            XCTAssertEqual(entity.timeZone, predicateEntity.timeZone)
            XCTAssertEqual(entity.timone, predicateEntity.timone)
            XCTAssertEqual(entity.sessionToken, predicateEntity.sessionToken)
            
            XCTAssertEqual(usecase?.signonResults.count, 1)
            
            exp.fulfill()
        }
        
        sut.input.loginTrigger.value = ("username","password")
        
        wait(for: [exp], timeout: 1.0)
    }
    
    
    // MARK: - Helpers
    
    private func makeSUT(file: StaticString = #file, line: UInt = #line) -> (sut: LoginViewModel, usecase: MockUseCase) {
        let usecase = MockUseCase()
        let sut = LoginViewModel(usecase)
        trackForMemoryLeaks(sut, file: file, line: line)
        trackForMemoryLeaks(usecase, file: file, line: line)
        return (sut, usecase)
    }
    
    private func paramData() -> [String : Any] {
        return ["username": "user1", "password":"password1"]
    }
    
    private func failureNSError() -> NSError {
        return NSError(domain: "any error", code: 0)
    }
    
    private class MockUseCase: LoginUseCase {
        private func failureNSError() -> NSError {
            return NSError(domain: "any error", code: 0)
        }
        
        func signon(param: [String : Any], with completion: @escaping (Result<LoginUserEntity, Error>) -> Void) {
            guard let result = signonResult else {
                completion(.failure(failureNSError()))
                return
            }
            self.signonResults.append(result)
            completion(result)
        }
        
        var signonResult: Result<LoginUserEntity, Error>?
        var signonResults: [Result<LoginUserEntity, Error>] = []
    }
}
