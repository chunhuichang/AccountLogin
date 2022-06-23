//
//  UpdateUserCoordinator.swift
//  AccountLogin
//
//  Created by Jill Chang on 2022/6/23.
//

import UIKit

// make DIContainer or ViewController
public protocol UpdateUserCoordinatorDependencies  {
    func makeUpdateUserViewController(param: UpdateUserCoordinator.Params?) -> UIViewController
}

public final class UpdateUserSceneDIContainer {
    struct Dependencies {
    }
    
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    // MARK: - Flow Coordinators
    func makeUpdateUserCoordinator(navigationController: UINavigationController?) -> UpdateUserCoordinator {
        return UpdateUserCoordinator(navigationController: navigationController, dependencies: self)
    }
}

extension UpdateUserSceneDIContainer: UpdateUserCoordinatorDependencies {
    public func makeUpdateUserViewController(param: UpdateUserCoordinator.Params?) -> UIViewController {
        // Data layer
        //        let repository = MainUpdateUserRepository()
        // Mock
        let repository = UpdateUserMockRepository()
        
        // Domain layer
        let usecase = MainUpdateUserUseCase(repository: repository)
        
        // Presentation layer
        let vm = UpdateUserViewModel(usecase)
        
        let view = UpdateUserViewController(viewModel: vm)
        return view
    }
}
