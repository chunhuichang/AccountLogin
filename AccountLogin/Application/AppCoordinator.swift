//
//  AppCoordinator.swift
//  AccountLogin
//
//  Created by Jill Chang on 2022/6/21.
//

import UIKit

public final class AppCoordinator {
    private let navigationController: UINavigationController
    private let appDIContainer: AppDIContainer
    
    public init(navigationController: UINavigationController, appDIContainer: AppDIContainer) {
        self.navigationController = navigationController
        self.appDIContainer = appDIContainer
    }
    
    public func start() {
        let loginDIContainer = appDIContainer.makeLoginSceneDIContainer()
        let coordinator = loginDIContainer.makeLoginCoordinator(navigationController: navigationController)
        coordinator.start()
    }
}
