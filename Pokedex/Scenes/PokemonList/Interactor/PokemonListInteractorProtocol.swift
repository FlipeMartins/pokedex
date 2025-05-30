//
//  PokemonListInteractorProtocol.swift
//  Pokedex
//
//  Created by Felipe Martins on 29/05/25.
//

import Foundation

protocol PokemonListInteractorProtocol {
    func startFlow(request: PokemonListModels.StartFlow.Request)
    func userSelectedItem(request: PokemonListModels.UserSelectedItem.Request)
}
