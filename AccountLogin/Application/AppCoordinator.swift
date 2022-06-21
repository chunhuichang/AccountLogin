//
//  AppCoordinator.swift
//  AccountLogin
//
//  Created by Jill Chang on 2022/6/21.
//

import UIKit

public final class AppCoordinator {
    public var rootVC: UIViewController?
    
    private let appDIContainer: AppDIContainer
    
    public init(appDIContainer: AppDIContainer) {
        self.appDIContainer = AppDIContainer()
    }
    
    public func start() {
//        let loadDataLoader = RemoteDataLoader()
//        let repository = MainTopListRepository(managedObjectContext: managedObjectContext)
        // Mock
        let repository = LoginMockRepository()
        let usecase = MainLoginUseCase(repository: repository)
        let vm = LoginViewModel(usecase)
//        vm.delegate = self
        self.rootVC =  LoginViewController(viewModel: vm)
    }
}
