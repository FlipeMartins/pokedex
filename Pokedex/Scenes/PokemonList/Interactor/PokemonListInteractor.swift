//
//  PokemonListInteractor.swift
//  Pokedex
//
//  Created by Felipe Martins on 29/05/25.
//

import Foundation

class PokemonListInteractor: PokemonListInteractorProtocol {
    
    private let presenter: PokemonListPresenterProtocol
    private let serviceManager: PokemonListServiceProtocol

    init(
        presenter: PokemonListPresenterProtocol,
        serviceManager: PokemonListServiceProtocol
    ) {
        self.presenter = presenter
        self.serviceManager = serviceManager
    }
    
}
