
//
//  ApplicationCoordinator.swift
//  Debtor_iOS
//
//  Created by Kerim Khasbulatov on 29.10.2022.
//

import Foundation

final class ApplicationCoordinator: BaseCoordinator {
    
    private let coordinatorFactory: CoordinatorFactory
    private let router: Router
    
    private var isFirstLaunch = true
    private var isLogin = false
    
    init(router: Router, coordinatorFactory: CoordinatorFactory) {
        self.router = router
        self.coordinatorFactory = coordinatorFactory
    }
    
    override func start() {
        if isFirstLaunch {
            runStartFlow()
            isFirstLaunch = false
            return
        }
        
        //        if isLogin {
        //            runMovieFlow()
        //        } else {
        //            runLoginFlow()
        //        }
        
        runLoginFlow()
    }
    
    private func runStartFlow() {
        
        let coordinator = coordinatorFactory.makeStartCoordinator(router: router)
        coordinator.finishFlow = { [weak self, weak coordinator] isLogin in
            self?.isLogin = isLogin
            self?.start()
            self?.removeDependency(coordinator)
        }
        self.addDependency(coordinator)
        coordinator.start()
    }
    
    private func runLoginFlow() {
        
        let coordinator = coordinatorFactory.makeLoginCoordinator(router: router)
        coordinator.finishFlow = { [weak self, weak coordinator] in
            self?.isLogin = true
            self?.start()
            self?.removeDependency(coordinator)
        }
        self.addDependency(coordinator)
        coordinator.start()
    }
    
}
