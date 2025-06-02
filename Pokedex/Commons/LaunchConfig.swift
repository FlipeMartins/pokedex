//
//  LaunchConfig.swift
//  Pokedex
//
//  Created by Felipe Martins on 01/06/25.
//

import Foundation

struct LaunchConfig {
    static let isUITest: Bool = CommandLine.arguments.contains("-UITestMode")
    
    static var useMocks: Bool {
        return isUITest
    }
}
