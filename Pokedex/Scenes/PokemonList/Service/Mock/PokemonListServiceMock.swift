//
//  PokemonListServiceMock.swift
//  Pokedex
//
//  Created by Felipe Martins on 30/05/25.
//

import Foundation

class PokemonListServiceMock: PokemonListServiceProtocol {
    
    enum MockError: Error {
        case someError
    }
    
    enum GetItemsConfiguration {
        case success
        case failure(Error)
    }
    
    struct Configuration {
        let getItemsConfiguration: GetItemsConfiguration
        
        init(getItemsConfiguration: GetItemsConfiguration = .success ) {
            self.getItemsConfiguration = getItemsConfiguration
        }
    }
    
    let configuration: Configuration
    
    init(configuration: Configuration = Configuration()) {
        self.configuration = configuration
    }
    
    func getItems(request: PokemonListServiceModel.GetItems.Request, completion: @escaping (Result<PokemonListServiceModel.GetItems.Response, Error>) -> Void) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            
            switch self.configuration.getItemsConfiguration {
            case .success:
                MockHelper.mockData(
                    of: PokemonListServiceModel.GetItems.Response.self,
                    fileName: "pokemon-list-get-items-success",
                    fileExtension: "json") { result in
                        
                        completion(.success(result))
                }
            case .failure:
                completion(.failure(MockError.someError))
            }
        }
    }
}
