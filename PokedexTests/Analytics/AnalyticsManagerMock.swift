//
//  AnalyticsManagerMock.swift
//  PokedexTests
//
//  Created by Felipe Martins on 01/06/25.
//

import Foundation
@testable import Pokedex

class AnalyticsManagerMock: AnalyticsManagerProtocol {
    
    var event: Pokedex.AnalyticsEventProtocol?
    var trackCalled: Bool = false
    
    func track(event: Pokedex.AnalyticsEventProtocol) {
        trackCalled = true
        self.event = event
        
    }
}
