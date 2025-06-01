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
    
    func presentStartLoading(response: PokemonDetailsModels.StartLoading.Response) {
        self.displayer?.displayStartLoading(viewModel: .init())
    }
    
    func presentStopLoading(response: PokemonDetailsModels.StopLoading.Response) {
        self.displayer?.displayStopLoading(viewModel: .init())
    }
    
    func presentEmptyState(response: PokemonDetailsModels.EmptyState.Response) {
        
        let title = self.dataProvider.emptyStateTitle
        let message = self.dataProvider.emptyStateMessage
        let image = PKMDSImage.asset(name: "psyduck")
        let buttonTitle = self.dataProvider.emptyStateButtonTitle
        
        self.displayer?.displayEmptyState(viewModel: .init(alertTitle: title, alertMessage: message, image: image, buttonTitle: buttonTitle))
    }
    
    func presentPokemonDetails(response: PokemonDetailsModels.PokemonDetails.Response) {
        self.displayer?.displayPokemonDetails(
            viewModel: .init(
                name: response.name.capitalized,
                image: response.image,
                types: response.types.compactMap{$0.capitalized},
                stats: response.stats.compactMap{PokemonDetailsModels.PokemonDetails.ViewModel.Stat(name: $0.name.capitalized, value: "\($0.value)".capitalized)}
            )
        )
    }
    
    
}
