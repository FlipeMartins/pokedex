//
//  PokemonListService.swift
//  Pokedex
//
//  Created by Felipe Martins on 29/05/25.
//

import Foundation

class PokemonListService: PokemonListServiceProtocol {
    
    func getItems(request: PokemonListServiceModel.GetItems.Request, completion: @escaping (Result<PokemonListServiceModel.GetItems.Response, Error>) -> Void) {
        // Get Pokemons Here
    }
}
