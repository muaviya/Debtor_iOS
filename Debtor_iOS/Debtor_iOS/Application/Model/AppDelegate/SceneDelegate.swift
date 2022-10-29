//
//  SceneDelegate.swift
//  Debtor_iOS
//
//  Created by Kerim Khasbulatov on 29.10.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private let appFactory: AppFactory = {
        let appFactory: AppFactory = TestConfiguration.shared.isTesting ? DiScreenshotMock() : Di()
        return appFactory
    }()
    
    private var appCoordinator: Coordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        runUI(windowScene: windowScene)
    }
    
    private func runUI(windowScene: UIWindowScene) {        
        let (window, coordinator) = appFactory.makeKeyWindowWithCoordinator(windowScene: windowScene)
        self.window = window
        self.appCoordinator = coordinator
        
        window.makeKeyAndVisible()
        coordinator.start()
    }
}


