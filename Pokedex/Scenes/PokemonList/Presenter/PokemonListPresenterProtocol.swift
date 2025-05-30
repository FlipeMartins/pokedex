//
//  PokemonListPresenterProtocol.swift
//  Pokedex
//
//  Created by Felipe Martins on 29/05/25.
//

import Foundation

protocol PokemonListPresenterProtocol {
    func presentStartLoading(response: PokemonListModels.StartLoading.Response)
    func presentStopLoading(response: PokemonListModels.StopLoading.Response)
    func presentEmptyState(response: PokemonListModels.EmptyState.Response)
    func presentShowItems(response: PokemonListModels.ShowItems.Response)
    func presentShowDetails(response: PokemonListModels.ShowDetails.Response)
}
