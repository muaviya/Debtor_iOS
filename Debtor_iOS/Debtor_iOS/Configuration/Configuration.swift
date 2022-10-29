//
//  Configuration.swift
//  Debtor_iOS
//
//  Created by Kerim Khasbulatov on 29.10.2022.
//

import Foundation

protocol Configuration {
    var host: String { get }
    var apiKey: String { get }
    var imageUrl: String { get }
}
