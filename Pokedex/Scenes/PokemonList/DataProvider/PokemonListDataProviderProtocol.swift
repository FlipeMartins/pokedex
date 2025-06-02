//
//  PokemonListDataProviderProtocol.swift
//  Pokedex
//
//  Created by Felipe Martins on 01/06/25.
//

import Foundation

protocol PokemonListDataProviderProtocol {
    
    var emptyStateTitle: String { get }
    var emptyStateMessage: String { get }
    var emptyStateButtonTitle: String { get }
}
