//
//  UpdateUserCoordinator.swift
//  AccountLogin
//
//  Created by Jill Chang on 2022/6/23.
//

import UIKit

// Current Coordinator send to prev Coordinator
public protocol UpdateUserDelegate: AnyObject {}

// Current Coordinator go to next Coordinator
public protocol UpdateUserCoordinatorDelegate: AnyObject {}

public final class UpdateUserCoordinator {
    public struct Params {
        let userEntity: LoginUserEntity
    }
    
    private weak var navigationController: UINavigationController?
    private let dependencies: UpdateUserCoordinatorDependencies
    private let param: UpdateUserCoordinator.Params?
    
    public init(navigationController: UINavigationController?, dependencies: UpdateUserCoordinatorDependencies, param: UpdateUserCoordinator.Params? = nil) {
        self.navigationController = navigationController
        self.dependencies = dependencies
        self.param = param
    }
    
    public func start() {
        guard let vc = dependencies.makeUpdateUserViewController(param: self.param) as? UpdateUserViewController else {
            fatalError("Casting to ViewController fail")
        }
        navigationController?.setViewControllers([vc], animated: true)
    }
}

extension UpdateUserCoordinator: UpdateUserDelegate{}

extension UpdateUserCoordinator: UpdateUserCoordinatorDelegate{}
