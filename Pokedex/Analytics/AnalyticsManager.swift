//
//  AnalyticsManager.swift
//  Pokedex
//
//  Created by Felipe Martins on 01/06/25.
//

import Foundation

protocol AnalyticsManagerProtocol {
    func track(event: AnalyticsEventProtocol)
}

struct AnalyticsEvent: AnalyticsEventProtocol {
    
    static var screenView: String = "screen-view"
    static var userInteraction: String = "user-interaction"
    
    var type: String
    var parameters: [String: Decodable]
}

class AnalyticsManager: AnalyticsManagerProtocol {
    
    public static var shared: AnalyticsManager = AnalyticsManager()
   
    private(set) var providers: [AnalyticsProviderProtocol] = []
    
    func add(provider: AnalyticsProviderProtocol) {
        self.providers.append(provider)
    }
    
    func track(event: AnalyticsEventProtocol) {
        for provider in providers {
            if provider.isTracking {
                provider.track(event: event)
            }
        }
    }
}
