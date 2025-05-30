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
    
    func presentStartLoading(response: PokemonListModels.StartLoading.Response) {
        self.displayer?.displayStartLoading(viewModel: .init())
    }
    
    func presentStopLoading(response: PokemonListModels.StopLoading.Response) {
        self.displayer?.displayStopLoading(viewModel: .init())
    }
    
    func presentEmptyState(response: PokemonListModels.EmptyState.Response) {
        let title = "Opa!"
        let message = "Parece que tivemos um problema para exibir os items, tente novamente mais tarde"
        self.displayer?.displayEmptyState(viewModel: .init(alertTitle: title, alertMessage: message))
    }
    
    func presentShowItems(response: PokemonListModels.ShowItems.Response) {
        let items = response.items.compactMap{PokemonListModels.ShowItems.ViewModel.ItemRepresentation(name: $0.name)}
        self.displayer?.displayShowItems(viewModel: .init(items: items))
    }
    
    func presentShowDetails(response: PokemonListModels.ShowDetails.Response) {
        self.displayer?.displayShowDetails(viewModel: .init(itemId: response.itemId))
    }
    
    
    
}
