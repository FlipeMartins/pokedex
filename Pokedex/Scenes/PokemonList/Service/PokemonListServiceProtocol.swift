//
//  PokemonListServiceProtocol.swift
//  Pokedex
//
//  Created by Felipe Martins on 29/05/25.
//

import Foundation

enum PokemonListServiceModel {
    enum GetItems {
        struct Request {
            
        }
        struct Response {
            let name: String
        }
    }
}

protocol PokemonListServiceProtocol {
    func getItems(request: PokemonListServiceModel.GetItems.Request, completion: @escaping (Result<[PokemonListServiceModel.GetItems.Response], Error>) -> Void)
}
