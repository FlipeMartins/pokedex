//
//  PokemonListService.swift
//  Pokedex
//
//  Created by Felipe Martins on 29/05/25.
//

import Foundation

class PokemonListService: PokemonListServiceProtocol {
    
    enum PokemonListServiceError: Error {
        case noData
    }
    
    
    func getItems(request: PokemonListServiceModel.GetItems.Request, completion: @escaping (Result<PokemonListServiceModel.GetItems.Response, Error>) -> Void) {
        
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=151") else { return }

            URLSession.shared.dataTask(with: url) { data, response, error in
                
                DispatchQueue.main.async {
                    
                    if let error = error {
                        completion(.failure(error))
                        return
                    }

                    guard let data = data else {
                        completion(.failure(PokemonListServiceError.noData))
                        return
                    }

                    do {
                        let result = try JSONDecoder().decode(PokemonListServiceModel.GetItems.Response.self, from: data)
                        completion(.success(result))
                    } catch {
                        completion(.failure(error))
                    }
                    
                }
                
                
            }.resume()
    }
}
