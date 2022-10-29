//
//  LoginStatusProviderScreenshotMock.swift
//  Debtor_iOS
//
//  Created by Kerim Khasbulatov on 29.10.2022.
//

import Foundation
import Combine

#if DEBUG

final class LoginStatusProviderScreenshotMock: LoginStatusProvider {
    var isLogin: Bool = false
}

#endif
