//
//  PokemonDetailsDisplayProtocol.swift
//  Pokedex
//
//  Created by Felipe Martins on 01/06/25.
//

import Foundation

protocol PokemonDetailsDisplayProtocol: AnyObject {
    
    func displayStartLoading(viewModel: PokemonDetailsModels.StartLoading.ViewModel)
    func displayStopLoading(viewModel: PokemonDetailsModels.StopLoading.ViewModel)
    func displayEmptyState(viewModel: PokemonDetailsModels.EmptyState.ViewModel)
    
}
