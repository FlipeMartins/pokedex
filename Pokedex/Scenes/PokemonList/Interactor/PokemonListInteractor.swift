//
//  PokemonListInteractor.swift
//  Pokedex
//
//  Created by Felipe Martins on 29/05/25.
//

import Foundation

class PokemonListInteractor: PokemonListInteractorProtocol {
    
    private let presenter: PokemonListPresenterProtocol
    private let service: PokemonListServiceProtocol

    init(
        presenter: PokemonListPresenterProtocol,
        service: PokemonListServiceProtocol
    ) {
        self.presenter = presenter
        self.service = service
    }
    
    func startFlow(request: PokemonListModels.StartFlow.Request) {
        self.presenter.presentStartLoading(response: .init())
        self.service.getItems(request: .init()) { result in
            self.presenter.presentStopLoading(response: .init())
            switch result {
            case .success(let items):
                let itemsToPresent = items.compactMap{PokemonListModels.ShowItems.Response.ItemRepresentation(name: $0.name)}
                self.presenter.presentShowItems(response: .init(items: itemsToPresent))
                
            case .failure(let failure):
                self.presenter.presentEmptyState(response: .init())
            }
        }
    }
    
    func userSelectedItem(request: PokemonListModels.UserSelectedItem.Request) {
        // Call show details passing ID
    }
    
}
