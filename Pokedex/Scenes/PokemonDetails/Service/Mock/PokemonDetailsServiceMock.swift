//
//  PokemonDetailsServiceMock.swift
//  Pokedex
//
//  Created by Felipe Martins on 01/06/25.
//

import Foundation

class PokemonDetailsServiceMock: PokemonDetailsServiceProtocol {
    
    enum MockError: Error {
        case someError
    }
    
    enum GetPokemonDetailsConfiguration {
        case success
        case failure(Error)
    }
    
    struct Configuration {
        let getPokemonDetailsConfiguration: GetPokemonDetailsConfiguration
        
        init(getPokemonDetailsConfiguration: GetPokemonDetailsConfiguration = .success ) {
            self.getPokemonDetailsConfiguration = getPokemonDetailsConfiguration
        }
    }
    
    let configuration: Configuration
    
    init(configuration: Configuration = Configuration()) {
        self.configuration = configuration
    }
    
    func getPokemonDetails(request: PokemonDetailServiceModel.GetPokemonDetails.Request, completion: @escaping (Result<PokemonDetailServiceModel.GetPokemonDetails.Response, Error>) -> Void) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            
            switch self.configuration.getPokemonDetailsConfiguration {
            case .success:
                MockHelper.mockData(
                    of: PokemonDetailServiceModel.GetPokemonDetails.Response.self,
                    fileName: "pokemon-details-get-pokemon-details",
                    fileExtension: "json") { result in
                        
                        completion(.success(result))
                }
            case .failure:
                completion(.failure(MockError.someError))
            }
        }
    }
}
