//
//  PokemonDetailsTestPresenterMock.swift
//  PokedexTests
//
//  Created by Felipe Martins on 01/06/25.
//

import Foundation
@testable import Pokedex
import XCTest

class PokemonDetailsTestPresenterMock: PokemonDetailsPresenterProtocol {
    
    var presentStartLoadingCalled: Bool = false
    var presentStopLoadingCalled: Bool = false
    var presentEmptyStateCalled: Bool = false
    var presentPokemonDetailsCalled: Bool = false
    
    func presentStartLoading(response: Pokedex.PokemonDetailsModels.StartLoading.Response) {
        self.presentStartLoadingCalled = true
    }
    
    func presentStopLoading(response: Pokedex.PokemonDetailsModels.StopLoading.Response) {
        self.presentStopLoadingCalled = true
    }
    
    func presentEmptyState(response: Pokedex.PokemonDetailsModels.EmptyState.Response) {
        self.presentEmptyStateCalled = true
    }
    
    func presentPokemonDetails(response: Pokedex.PokemonDetailsModels.PokemonDetails.Response) {
        self.presentPokemonDetailsCalled = true
    }
    
    
}
