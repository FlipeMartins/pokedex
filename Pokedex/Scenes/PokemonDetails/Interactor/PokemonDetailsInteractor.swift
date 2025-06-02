//
//  PokemonDetailsInteractor.swift
//  Pokedex
//
//  Created by Felipe Martins on 01/06/25.
//

import Foundation

class PokemonDetailsInteractor: PokemonDetailsInteractorProtocol {
    
    struct InputData {
        let itemId: Int
    }
    
    private let presenter: PokemonDetailsPresenterProtocol
    private let service: PokemonDetailsServiceProtocol
    private var analyticsManager: AnalyticsManagerProtocol
    
    private var inputData: InputData

    init(
        inputData: InputData,
        presenter: PokemonDetailsPresenterProtocol,
        service: PokemonDetailsServiceProtocol,
        analyticsManager: AnalyticsManagerProtocol = AnalyticsManager.shared
    ) {
        self.inputData = inputData
        self.presenter = presenter
        self.service = service
        self.analyticsManager = analyticsManager
    }
    
    func startFlow(request: PokemonDetailsModels.StartFlow.Request) {
     
        analyticsManager.track(
            event: AnalyticsEvent(
                type: !request.isRetry ? AnalyticsEvent.screenView : AnalyticsEvent.userInteraction,
                parameters: ["Screen":"PokeonDetailsViewController", "isRetry": request.isRetry, "tag":"PokemonDetails_startFlow"]
            )
        )
        
        self.presenter.presentStartLoading(response: .init())
        self.service.getPokemonDetails(request: .init(itemId: inputData.itemId)) { result in
            self.presenter.presentStopLoading(response: .init())
            switch result {
            case .success(let result):
                
                let name = result.name
                let image = PKMDSImage.remote(remote: .init(url: result.sprites.other.officialArtwork.frontDefault))
                let types = result.types.compactMap{$0.type.name}
                let stats = result.stats.compactMap{PokemonDetailsModels.PokemonDetails.Response.Stat(name: $0.stat.name, value: $0.baseStat)}
                
                self.presenter.presentPokemonDetails(
                    response: .init(
                        name: name,
                        image: image,
                        types: types,
                        stats: stats
                    )
                )
            case .failure(_):
                self.presenter.presentEmptyState(response: .init())
            }
        }
    }
    
}
