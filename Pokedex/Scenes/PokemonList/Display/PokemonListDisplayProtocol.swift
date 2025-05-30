//
//  PokemonListDisplayProtocol.swift
//  Pokedex
//
//  Created by Felipe Martins on 29/05/25.
//

import Foundation

protocol PokemonListDisplayProtocol: AnyObject {
    func displayStartLoading(viewModel: PokemonListModels.StartLoading.ViewModel)
    func displayStopLoading(viewModel: PokemonListModels.StopLoading.ViewModel)
    func displayEmptyState(viewModel: PokemonListModels.EmptyState.ViewModel)
    func displayShowItems(viewModel: PokemonListModels.ShowItems.ViewModel)
    func displayShowDetails(viewModel: PokemonListModels.ShowDetails.ViewModel)
}
