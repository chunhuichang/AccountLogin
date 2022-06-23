//
//  AppDIContainer.swift
//  AccountLogin
//
//  Created by Jill Chang on 2022/6/21.
//

import UIKit

public final class AppDIContainer {
    
    
    // MARK: - DIContainers of scenes
    func makeLoginSceneDIContainer() -> LoginSceneDIContainer {
        let dependencies = LoginSceneDIContainer.Dependencies()
        return LoginSceneDIContainer(dependencies: dependencies)
    }
}


