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
    private let analyticsManager: AnalyticsManagerProtocol

    init(
        presenter: PokemonListPresenterProtocol,
        service: PokemonListServiceProtocol,
        analyticsManager: AnalyticsManagerProtocol = AnalyticsManager.shared
    ) {
        self.presenter = presenter
        self.service = service
        self.analyticsManager = analyticsManager
    }
    
    func startFlow(request: PokemonListModels.StartFlow.Request) {
        
        analyticsManager.track(
            event: AnalyticsEvent(
                type: !request.isRetry ? AnalyticsEvent.screenView : AnalyticsEvent.userInteraction,
                parameters: ["Screen":"PokemonListViewController", "isRetry": request.isRetry, "tag":"PokemonList_startFlow"]
            )
        )
        
        
        self.presenter.presentStartLoading(response: .init())
        self.service.getItems(request: .init()) { result in
            self.presenter.presentStopLoading(response: .init())
            switch result {
            case .success(let result):
                let itemsToPresent = result.results.compactMap{PokemonListModels.ShowItems.Response.ItemRepresentation(name: $0.name)}
                self.presenter.presentShowItems(response: .init(items: itemsToPresent))
                
            case .failure(_):
                self.presenter.presentEmptyState(response: .init())
            }
        }
    }
    
    func userSelectedItem(request: PokemonListModels.UserSelectedItem.Request) {
        
        let itemId = request.index + 1
        
        analyticsManager.track(
            event: AnalyticsEvent(
                type: AnalyticsEvent.userInteraction,
                parameters: ["Screen":"PokemonListViewController", "itemId": itemId, "tag":"PokemonList_startFlow"]
            )
        )
        
        
        self.presenter.presentShowDetails(response: .init(itemId: itemId))
    }
    
}
