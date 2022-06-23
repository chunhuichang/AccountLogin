//
//  LoginCoordinator.swift
//  AccountLogin
//
//  Created by Jill Chang on 2022/6/23.
//

import UIKit

// Current Coordinator send to prev Coordinator
public protocol LoginDelegate: AnyObject {}

// Current Coordinator go to next Coordinator
public protocol LoginCoordinatorDelegate: AnyObject {
    func showUpdateUser()
}

public final class LoginCoordinator {
    public struct Params {}
    
    private weak var navigationController: UINavigationController?
    private let dependencies: LoginCoordinatorDependencies
    
    public init(navigationController: UINavigationController, dependencies: LoginCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    public func start() {
        guard let vc = dependencies.makeLoginViewController(param: nil) as? LoginViewController else {
            fatalError("Casting to ViewController fail")
        }
        vc.viewModel.coordinatorDelegate = self
        navigationController?.pushViewController(vc, animated: false)
    }
}

extension LoginCoordinator: LoginCoordinatorDelegate {
    public func showUpdateUser() {
        let DIContainer = dependencies.makeUpdateUserSceneDIContainer()
        let coordinator = DIContainer.makeUpdateUserCoordinator(navigationController: navigationController)
        coordinator.start()
    }
}

extension LoginCoordinator: LoginDelegate {}
