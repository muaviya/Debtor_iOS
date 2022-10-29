//
//  LoginScreenVC.swift
//  Debtor_iOS
//
//  Created by Kerim Khasbulatov on 29.10.2022.
//

import UIKit

class LoginScreenVC<View: LoginScreenView>: BaseViewController<View> {
    
    typealias ErrorMessage = String
    
    var onLogin: VoidClosure?
    
    private let loginProvider: LoginProvider
    
    init(loginProvider: LoginProvider) {
        self.loginProvider = loginProvider
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        rootView.udapte(with: makeLoginScreenViewInputData(from: loginProvider.state.value))
    }
    
    private func makeLoginScreenViewInputData(from state: LoginProviderState) -> LoginScreenViewInputData {
        let isCanSubmit = state.loginCredentials != nil && !state.isAuthInProgress
        
        let errorMessage = state.error.map(makeErrorMessage)
        
        return LoginScreenViewInputData(isCanSubmit: isCanSubmit, errorMessage: errorMessage)
    }
    
    private func makeErrorMessage(from error: Error) -> String {
        switch error {
        case let error as ApiClientError where error == .unauthorized:
            return "Invalid username and/or password: You did not provide a valid login."
        default:
            return "Developer mistake. Please try turning it off and on again"
        }
    }
}
