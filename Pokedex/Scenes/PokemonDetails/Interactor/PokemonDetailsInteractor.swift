//
//  PokemonDetailsInteractor.swift
//  Pokedex
//
//  Created by Felipe Martins on 01/06/25.
//

import Foundation

class PokemonDetailsInteractor: PokemonDetailsInteractorProtocol {
    
    private let presenter: PokemonDetailsPresenterProtocol
    private let service: PokemonDetailsServiceProtocol

    init(
        presenter: PokemonDetailsPresenterProtocol,
        service: PokemonDetailsServiceProtocol
    ) {
        self.presenter = presenter
        self.service = service
    }
    
}
