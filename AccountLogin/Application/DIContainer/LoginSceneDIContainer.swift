//
//  LoginSceneDIContainer.swift
//  AccountLogin
//
//  Created by Jill Chang on 2022/6/23.
//

import UIKit

// make DIContainer or ViewController
public protocol LoginCoordinatorDependencies  {
    func makeLoginViewController(param: LoginCoordinator.Params?) -> UIViewController
    
    func makeUpdateUserSceneDIContainer() -> UpdateUserSceneDIContainer
}

public final class LoginSceneDIContainer {
    struct Dependencies {
        let loadDataLoader: DataServiceLoader
    }
    
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    // MARK: - Flow Coordinators
    func makeLoginCoordinator(navigationController: UINavigationController) -> LoginCoordinator {
        return LoginCoordinator(navigationController: navigationController, dependencies: self)
    }
}

extension LoginSceneDIContainer: LoginCoordinatorDependencies {
    public func makeLoginViewController(param: LoginCoordinator.Params?) -> UIViewController {
        
        // Data layer
        let repository = MainLoginRepository(loadDataLoader: self.dependencies.loadDataLoader)
        // Mock
//        let repository = LoginMockRepository()
        
        // Domain layer
        let usecase = MainLoginUseCase(repository: repository)
        
        // Presentation layer
        let vm = LoginViewModel(usecase)
        
        let view = LoginViewController(viewModel: vm)
        return view
    }
    
    // MARK: - DIContainers of scenes
    public func makeUpdateUserSceneDIContainer() -> UpdateUserSceneDIContainer {
        let dependencies = UpdateUserSceneDIContainer.Dependencies()
        return UpdateUserSceneDIContainer(dependencies: dependencies)
    }
}
