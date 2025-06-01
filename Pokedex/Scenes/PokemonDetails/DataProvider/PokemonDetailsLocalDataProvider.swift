//
//  PokemonDetailsLocalDataProvider.swift
//  Pokedex
//
//  Created by Felipe Martins on 01/06/25.
//

import Foundation

class PokemonDetailsLocalDataProvider: PokemonDetailsDataProviderProtocol {
    
    var emptyStateTitle: String {
        "Opa!"
    }
    
    var emptyStateMessage: String {
        "Parece que tivemos um problema para exibir os items, tente novamente mais tarde"
    }
    
    var emptyStateButtonTitle: String {
        "Tentar novamente"
    }

}
