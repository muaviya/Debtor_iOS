//
//  DiScreenshotMock.swift
//  Debtor_iOS
//
//  Created by Kerim Khasbulatov on 29.10.2022.
//

import UIKit
import class Alamofire.Session

#if DEBUG

final class DiScreenshotMock {
    
    fileprivate let screenFactory: ScreenFactoryScreenshotMock
    fileprivate let coordinatorFactory: CoordinatorFactoryScreenshotMock
    
    fileprivate var loginProvider: LoginProvider {
        return LoginProviderScreenshotMock()
    }
    
    fileprivate var loginStatusProvider: LoginStatusProvider {
        return LoginStatusProviderScreenshotMock()
    }
    
    init() {
        self.screenFactory = ScreenFactoryScreenshotMock()
        self.coordinatorFactory = CoordinatorFactoryScreenshotMock(screenFactory: screenFactory)
        screenFactory.di = self
    }
    
}

extension DiScreenshotMock: AppFactory {
    
    func makeKeyWindowWithCoordinator(windowScene: UIWindowScene) -> (UIWindow, Coordinator) {
        UIView.setAnimationsEnabled(false)
        let window = UIWindow(windowScene: windowScene)
        let rootVC = UINavigationController()
        rootVC.navigationBar.prefersLargeTitles = true
        let router = RouterImp(rootController: rootVC)
        let cooridnator = coordinatorFactory.makeApplicationCoordinator(router: router)
        window.rootViewController = rootVC
        return (window, cooridnator)
    }
    
}

final class ScreenFactoryScreenshotMock: ScreenFactory {
    fileprivate weak var di: DiScreenshotMock!
    fileprivate init(){}

    func makeLoginScreen() -> LoginScreenVC<LoginScreenViewImpl> {
        return LoginScreenVC<LoginScreenViewImpl>(loginProvider: di.loginProvider)
    }
}


final class CoordinatorFactoryScreenshotMock {
    
    private let screenFactory: ScreenFactory
    
    fileprivate init(screenFactory: ScreenFactory){
        self.screenFactory = screenFactory
    }
    
    func makeApplicationCoordinator(router: Router) -> ApplicationCoordinatorScreenshotMock {
        return ApplicationCoordinatorScreenshotMock(router: router, screenFactory: screenFactory)
    }
    
}

#endif
