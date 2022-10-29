//
//  ProcessInfoEnvironmentProvider.swift
//  Debtor_iOS
//
//  Created by Kerim Khasbulatov on 29.10.2022.
//

import Foundation

class ProcessInfoEnvironmentProvider<T> where T: RawRepresentable, T.RawValue == String {
    
    func contains(argument: T) -> Bool {
        ProcessInfo.processInfo.arguments.contains(argument.rawValue)
    }
    
    func environment(key: T) -> String? {
        ProcessInfo.processInfo.environment[key.rawValue]
    }
    
}
