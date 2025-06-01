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
    
    private var inputData: InputData

    init(
        inputData: InputData,
        presenter: PokemonDetailsPresenterProtocol,
        service: PokemonDetailsServiceProtocol
    ) {
        self.inputData = inputData
        self.presenter = presenter
        self.service = service
    }
    
    func startFlow(request: PokemonDetailsModels.StartFlow.Request) {
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
