//
//  PokemonListPresenter.swift
//  Pokedex
//
//  Created by Felipe Martins on 29/05/25.
//

import Foundation

class PokemonListPresenter: PokemonListPresenterProtocol {
    
    private weak var displayer: PokemonListDisplayProtocol?
    private var dataProvider: PokemonListDataProviderProtocol
    
    init(displayer: PokemonListDisplayProtocol, dataProvider: PokemonListDataProviderProtocol = PokemonListLocalDataProvider()) {
        self.displayer = displayer
        self.dataProvider = dataProvider
    }
    
    func presentStartLoading(response: PokemonListModels.StartLoading.Response) {
        self.displayer?.displayStartLoading(viewModel: .init())
    }
    
    func presentStopLoading(response: PokemonListModels.StopLoading.Response) {
        self.displayer?.displayStopLoading(viewModel: .init())
    }
    
    func presentEmptyState(response: PokemonListModels.EmptyState.Response) {
        
        let title = self.dataProvider.emptyStateTitle
        let message = self.dataProvider.emptyStateMessage
        let image = PKMDSImage.asset(name: "psyduck")
        let buttonTitle = self.dataProvider.emptyStateButtonTitle
        
        self.displayer?.displayEmptyState(viewModel: .init(alertTitle: title, alertMessage: message, image: image, buttonTitle: buttonTitle))
    }
    
    func presentShowItems(response: PokemonListModels.ShowItems.Response) {
        let items = response.items.enumerated().compactMap{
            PokemonListModels.ShowItems.ViewModel.ItemRepresentation(
                name: $0.element.name.capitalized,
                image: .remote(
                    remote: .init(
                        url: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\($0.offset + 1).png")
                )
            )
        }
        self.displayer?.displayShowItems(viewModel: .init(items: items))
    }
    
    func presentShowDetails(response: PokemonListModels.ShowDetails.Response) {
        self.displayer?.displayShowDetails(viewModel: .init(itemId: response.itemId))
    }
}
