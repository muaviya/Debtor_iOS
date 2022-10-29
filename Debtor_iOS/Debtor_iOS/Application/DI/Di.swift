//
//  Di.swift
//  Debtor_iOS
//
//  Created by Kerim Khasbulatov on 29.10.2022.
//

import UIKit
import class Alamofire.Session

final class Di {
    
    fileprivate let configuration: Configuration
    fileprivate let session: Session
    
    fileprivate let keychainWrapper: KeychainWrapperImpl
    
    
    fileprivate let requestBuilder: RequestBuilderImpl
    fileprivate let sessionRepository: SessionRepositoryImpl
    fileprivate let baseJsonDecoder: JSONDecoder
    fileprivate let apiClient: ApiClient
    fileprivate let screenFactory: ScreenFactoryImpl
    fileprivate let coordinatorFactory: CoordinatorFactoryImpl
    fileprivate var authenticatorService: AuthenticatorServiceImpl
    
    
    fileprivate var loginProvider: LoginProviderImpl {
        return LoginProviderImpl(authenticator: authenticatorService)
    }
    
    fileprivate var loginStatusProvider: LoginStatusProviderImpl {
        return LoginStatusProviderImpl(authenticatorService: authenticatorService)
    }
    
    init() {
        configuration = ProductionConfiguration()
        session = Session.default
        keychainWrapper = KeychainWrapperImpl.standard
        requestBuilder = RequestBuilderImpl(configuration: configuration)
        sessionRepository = SessionRepositoryImpl(keychainWrapper: keychainWrapper)
        baseJsonDecoder = JSONDecoder.makeBaseDecoder()
        apiClient = ApiClient(requestBuilder: requestBuilder, session: session, decoder: baseJsonDecoder)
        screenFactory = ScreenFactoryImpl()
        coordinatorFactory = CoordinatorFactoryImpl(screenFactory: screenFactory)
        authenticatorService = AuthenticatorServiceImpl(sessionRepository: sessionRepository, accountApiClient: apiClient)
        
        screenFactory.di = self
    }
}

protocol AppFactory {
    func makeKeyWindowWithCoordinator(windowScene: UIWindowScene) -> (UIWindow, Coordinator)
}

extension Di: AppFactory {
    
    func makeKeyWindowWithCoordinator(windowScene: UIWindowScene) -> (UIWindow, Coordinator) {
        let window = UIWindow(windowScene: windowScene)
        let rootVC = UINavigationController()
        rootVC.navigationBar.prefersLargeTitles = true
        let router = RouterImp(rootController: rootVC)
        let cooridnator = coordinatorFactory.makeApplicationCoordinator(router: router)
        window.rootViewController = rootVC
        return (window, cooridnator)
    }
    
}

protocol ScreenFactory {
    func makeLoginScreen() -> LoginScreenVC<LoginScreenViewImpl>
}

final class ScreenFactoryImpl: ScreenFactory {
    fileprivate weak var di: Di!
    fileprivate init(){}

    func makeLoginScreen() -> LoginScreenVC<LoginScreenViewImpl> {
        return LoginScreenVC<LoginScreenViewImpl>(loginProvider: di.loginProvider)
    }
}

protocol CoordinatorFactory {
    
    func makeApplicationCoordinator(router: Router) -> ApplicationCoordinator
    
    func makeLoginCoordinator(router: Router) -> LoginCoordinator
    
    func makeStartCoordinator(router: Router) -> StartCoordinator
}

final class CoordinatorFactoryImpl: CoordinatorFactory {
    
    private let screenFactory: ScreenFactory
    
    fileprivate init(screenFactory: ScreenFactory){
        self.screenFactory = screenFactory
    }
    
    func makeApplicationCoordinator(router: Router) -> ApplicationCoordinator {
        return ApplicationCoordinator(router: router, coordinatorFactory: self)
    }
    
    func makeLoginCoordinator(router: Router) -> LoginCoordinator {
        return LoginCoordinator(router: router, screenFactory: screenFactory)
    }
    
    func makeStartCoordinator(router: Router) -> StartCoordinator {
        return StartCoordinator(router: router, screenFactory: screenFactory)
    }
}


