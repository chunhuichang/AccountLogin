//
//  AppDIContainer.swift
//  AccountLogin
//
//  Created by Jill Chang on 2022/6/21.
//

import UIKit

public final class AppDIContainer {
    
    // MARK: - Network
    let loadDataLoader = RemoteDataLoader()
    
    // MARK: - DIContainers of scenes
    func makeLoginSceneDIContainer() -> LoginSceneDIContainer {
        let dependencies = LoginSceneDIContainer.Dependencies(loadDataLoader: loadDataLoader)
        return LoginSceneDIContainer(dependencies: dependencies)
    }
}
