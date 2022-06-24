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
        
        sut.input.loginAction(userName: "username", password: "password")
        
        wait(for: [exp], timeout: 1.0)
    }
    
    func test_correctDataTriggerlogin_successLoginGetUserObject() {
        let (sut, usecase) = makeSUT()
        
        let predicateEntity = LoginUserEntity(objectID: "objectID", username: "username@qq.com", code: "code", timezone: 20, parameter: 8, number: 5, phone: "0900000000", timeZone: "Asia/Taipei", timone: "10", sessionToken: "r:pnktnjyb996sj4p156gjtp4im")
        
        usecase.signonResult = .success(predicateEntity)
        let mockDelegate = MockLoginCoordinatorDelegate(testCase: self)
        sut.coordinatorDelegate = mockDelegate
        
        mockDelegate.expectUpdateUserEntity()
        sut.input.loginAction(userName: "username", password: "password")
        
        waitForExpectations(timeout: 1.0)
        
        XCTAssertEqual(mockDelegate.showUpdateUserEntity?.objectID, predicateEntity.objectID)
        XCTAssertEqual(mockDelegate.showUpdateUserEntity?.username, predicateEntity.username)
        XCTAssertEqual(mockDelegate.showUpdateUserEntity?.timezone, predicateEntity.timezone)
        XCTAssertEqual(mockDelegate.showUpdateUserEntity?.parameter, predicateEntity.parameter)
        XCTAssertEqual(mockDelegate.showUpdateUserEntity?.number, predicateEntity.number)
        XCTAssertEqual(mockDelegate.showUpdateUserEntity?.phone, predicateEntity.phone)
        XCTAssertEqual(mockDelegate.showUpdateUserEntity?.timeZone, predicateEntity.timeZone)
        XCTAssertEqual(mockDelegate.showUpdateUserEntity?.timone, predicateEntity.timone)
        XCTAssertEqual(mockDelegate.showUpdateUserEntity?.sessionToken, predicateEntity.sessionToken)
    }
    
    
    // MARK: - Helpers
    
    private func makeSUT(file: StaticString = #file, line: UInt = #line) -> (sut: LoginViewModel, usecase: MockUseCase) {
        let usecase = MockUseCase()
        let sut = LoginViewModel(usecase)
        trackForMemoryLeaks(sut, file: file, line: line)
        trackForMemoryLeaks(usecase, file: file, line: line)
        return (sut, usecase)
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
    
    private class MockLoginCoordinatorDelegate: LoginCoordinatorDelegate {
        var showUpdateUserEntity: LoginUserEntity?
        private var expectation: XCTestExpectation?
        private let testCase: XCTestCase
        
        init(testCase: XCTestCase) {
            self.testCase = testCase
        }
        
        func expectUpdateUserEntity() {
            expectation = testCase.expectation(description: "Expect showUpdateUserEntity")
        }
        
        func showUpdateUser(entity: LoginUserEntity) {
            if expectation != nil {
                self.showUpdateUserEntity = entity
            }
            expectation?.fulfill()
            expectation = nil
            
        }
    }
}
