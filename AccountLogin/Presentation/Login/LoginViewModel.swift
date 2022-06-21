//
//  LoginViewModel.swift
//  AccountLogin
//
//  Created by Jill Chang on 2022/6/21.
//

import Foundation

// Input
public protocol LoginVMInput {
    var loginTrigger: Box<(userName: String, password: String)> { get }
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
        self.bindingInOut()
    }
    
    public var input: LoginVMInput {
        return self
    }
    public var output: LoginVMOutput {
        return self
    }
    
    // input
    public var loginTrigger: Box<(userName: String, password: String)> = Box(nil)
    
    //output
    public var isLoading: Box<Bool> = Box(false)
    public var alertMessage: Box<(title: String, message: String)> = Box(nil)
    public var userData: Box<LoginUserEntity> = Box(nil)
}

// MARK: input binding
extension LoginViewModel {
    private func bindingInOut() {
        loginTrigger.binding(trigger: false) { [weak self] newValue, _ in
            guard let self = self, let loginData = newValue else { return }
            
            var param = [String: String]()
            param["username"] = loginData.userName
            param["password"] = loginData.password
            self.isLoading.value = true
            self.usecase?.signon(param: param, with: { result in
                self.isLoading.value = false
                switch result {
                case .success(let entity):
                    self.userData.value = entity
                    
                case.failure(let error):
                    self.alertMessage.value = (title: "Error", message: error.localizedDescription)
                }
            })
        }
    }
}
