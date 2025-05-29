//
//  PokemonListPresenter.swift
//  Pokedex
//
//  Created by Felipe Martins on 29/05/25.
//

import Foundation

class PokemonListPresenter: PokemonListPresenterProtocol {
    
    private weak var displayer: PokemonListDisplayProtocol?
    
    init(displayer: PokemonListDisplayProtocol) {
        self.displayer = displayer
    }
    
}
