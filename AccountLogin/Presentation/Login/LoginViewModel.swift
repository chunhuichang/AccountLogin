//
//  LoginViewModel.swift
//  AccountLogin
//
//  Created by Jill Chang on 2022/6/21.
//

import Foundation

// Input
public protocol LoginVMInput {
    func loginAction(userName: String?, password: String?)
}

// Output
public protocol LoginVMOutput {
    var isLoading: Box<Bool> { get }
    var alertMessage: Box<(title: String, message: String)> { get }
    var userData: Box<LoginUserEntity> { get }
}

// Manager
public protocol LoginVMManager {
    var input: LoginVMInput { get }
    var output: LoginVMOutput { get }
}

public final class LoginViewModel: LoginVMInput, LoginVMOutput, LoginVMManager {
    
    var usecase: LoginUseCase?
    
    public init(_ usecase: LoginUseCase) {
        self.usecase = usecase
    }
    
    public var input: LoginVMInput {
        return self
    }
    public var output: LoginVMOutput {
        return self
    }
    
    //output
    public var isLoading: Box<Bool> = Box(false)
    public var alertMessage: Box<(title: String, message: String)> = Box(nil)
    public var userData: Box<LoginUserEntity> = Box(nil)
}

// input
extension LoginViewModel {
    public func loginAction(userName: String?, password: String?) {
        guard let userName = userName, let password = password else {
            self.alertMessage.value = (title: "Error", message: "user name or password is nil")
            return
        }
        
        var param = [String: String]()
        param["username"] = userName
        param["password"] = password
        self.isLoading.value = true
        self.usecase?.signon(param: param, with: { result in
            self.isLoading.value = false
            switch result {
            case .success(let entity):
                self.userData.value = entity
                
                self.alertMessage.value = (title: "Success", message: "get user info object")
            case.failure(let error):
                self.alertMessage.value = (title: "Error", message: error.localizedDescription)
            }
        })
    }
}
