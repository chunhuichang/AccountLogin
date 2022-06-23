//
//  UpdateUserViewModel.swift
//  AccountLogin
//
//  Created by Jill Chang on 2022/6/22.
//

import Foundation

// Input
public protocol UpdateUserVMInput {
    func updateUserAction(timezone: String?, number: String?, phone: String?)
}

// Output
public protocol UpdateUserVMOutput {
    var isLoading: Box<Bool> { get }
    var alertMessage: Box<(title: String, message: String)> { get }
    var userObject: Box<LoginUserEntity> { get }
}

// Manager
public protocol UpdateUserVMManager {
    var input: UpdateUserVMInput { get }
    var output: UpdateUserVMOutput { get }
}

public final class UpdateUserViewModel: UpdateUserVMInput, UpdateUserVMOutput, UpdateUserVMManager {
    
    private var usecase: UpdateUserUseCase?
    
    public init(_ usecase: UpdateUserUseCase, param: UpdateUserCoordinator.Params? = nil) {
        self.usecase = usecase
        self.userObject = Box(param?.userEntity)
    }
    
    public var input: UpdateUserVMInput {
        return self
    }
    public var output: UpdateUserVMOutput {
        return self
    }
    
    //output
    public var isLoading: Box<Bool> = Box(false)
    public var alertMessage: Box<(title: String, message: String)> = Box(nil)
    public var userObject: Box<LoginUserEntity>
}

// input
extension UpdateUserViewModel {
    public func updateUserAction(timezone: String?, number: String?, phone: String?) {
        guard let timezone = timezone, let number = number, let phone = phone else {
            self.alertMessage.value = (title: "Error", message: "user name or password is nil")
            return
        }
        
        var param = [String: Any]()
        param["timezone"] = timezone
        param["number"] = number
        param["phone"] = phone
        
        self.isLoading.value = true
        self.usecase?.updateUser(param: param, with: { result in
            self.isLoading.value = false
            switch result {
            case .success:
                self.alertMessage.value = (title: "Success", message: "update user info object")
            case.failure(let error):
                self.alertMessage.value = (title: "Error", message: error.localizedDescription)
            }
        })
    }
}
