//
//  ConsoleAnalyticsProvider.swift
//  Pokedex
//
//  Created by Felipe Martins on 01/06/25.
//

import Foundation

class ConsoleAnalyticsProvider: AnalyticsProviderProtocol {
    var name: String {
        "ConsoleAnalyticsProvider"
    }
    
    var isTracking: Bool {
        return true
    }
    
    func track(event: AnalyticsEventProtocol) {
        print("[\(name)]: \(event.type) - \(event.parameters)")
    }
}
