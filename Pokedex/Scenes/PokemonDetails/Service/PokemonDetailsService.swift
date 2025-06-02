//
//  PokemonDetailsService.swift
//  Pokedex
//
//  Created by Felipe Martins on 01/06/25.
//

import Foundation

class PokemonDetailsService: PokemonDetailsServiceProtocol {
    
    enum PokemonDetailsServiceError: Error {
        case noData
    }
    
    func getPokemonDetails(request: PokemonDetailServiceModel.GetPokemonDetails.Request, completion: @escaping (Result<PokemonDetailServiceModel.GetPokemonDetails.Response, Error>) -> Void) {
        
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(request.itemId)/") else { return }

            URLSession.shared.dataTask(with: url) { data, response, error in
                
                DispatchQueue.main.async {
                    
                    if let error = error {
                        completion(.failure(error))
                        return
                    }

                    guard let data = data else {
                        completion(.failure(PokemonDetailsServiceError.noData))
                        return
                    }

                    do {
                        let result = try JSONDecoder().decode(PokemonDetailServiceModel.GetPokemonDetails.Response.self, from: data)
                        completion(.success(result))
                    } catch {
                        completion(.failure(error))
                    }
                    
                }
                
                
            }.resume()
        
    }
    
}
