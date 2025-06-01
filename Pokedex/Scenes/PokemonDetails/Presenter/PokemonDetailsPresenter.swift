//
//  PokemonDetailsPresenter.swift
//  Pokedex
//
//  Created by Felipe Martins on 01/06/25.
//

import Foundation

class PokemonDetailsPresenter: PokemonDetailsPresenterProtocol {
    
    private weak var displayer: PokemonDetailsDisplayProtocol?
    private var dataProvider: PokemonDetailsDataProviderProtocol
    
    init(displayer: PokemonDetailsDisplayProtocol, dataProvider: PokemonDetailsDataProviderProtocol = PokemonDetailsLocalDataProvider()) {
        self.displayer = displayer
        self.dataProvider = dataProvider
    }
    
}
