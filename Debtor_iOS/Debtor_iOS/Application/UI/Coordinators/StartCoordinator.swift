//
//  StartCoordinator.swift
//  Debtor_iOS
//
//  Created by Kerim Khasbulatov on 29.10.2022.
//

import Foundation

final class StartCoordinator: BaseCoordinator {
    
    var finishFlow: BoolClosure?
    
    private let screenFactory: ScreenFactory
    private let router: Router
    
    init(router: Router, screenFactory: ScreenFactory) {
        self.screenFactory = screenFactory
        self.router = router
    }
    
    override func start() {
        showSplash()
    }
    
    private func showSplash() {
        let loginScreen = screenFactory.makeLoginScreen()
        router.setRootModule(loginScreen, hideBar: true)
    }
}
