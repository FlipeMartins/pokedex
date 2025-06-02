//
//  AnalyticsManager.swift
//  Pokedex
//
//  Created by Felipe Martins on 01/06/25.
//

import Foundation

protocol AnalyticsEventProtocol {
    var type: String { get }
    var parameters: [String:Decodable] { get }
}

protocol AnalyticsProviderProtocol {
    var name: String { get }
    var isTracking: Bool { get }
    func track(event: AnalyticsEventProtocol)
}
