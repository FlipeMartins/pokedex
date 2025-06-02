//
//  PokemonDetailsPresenterProtocol.swift
//  Pokedex
//
//  Created by Felipe Martins on 01/06/25.
//

import Foundation

protocol PokemonDetailsPresenterProtocol {
    
    func presentStartLoading(response: PokemonDetailsModels.StartLoading.Response)
    func presentStopLoading(response: PokemonDetailsModels.StopLoading.Response)
    func presentEmptyState(response: PokemonDetailsModels.EmptyState.Response)
    func presentPokemonDetails(response: PokemonDetailsModels.PokemonDetails.Response)
}
