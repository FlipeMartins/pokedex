//
//  PokemonDetailsTestServiceMock.swift
//  PokedexTests
//
//  Created by Felipe Martins on 01/06/25.
//

import Foundation
@testable import Pokedex
import XCTest

class PokemonDetailsTestServiceMock: PokemonDetailsServiceProtocol {
    
    enum MockError: Error {
        case some
    }
    
    enum Configuration {
        case sucess
        case failure
    }
    
    var configuration: Configuration = .sucess
    
    var getPokemonDetailsCalled: Bool = false
    var getPokemonDetailsExpectation: XCTestExpectation?
    
    func getPokemonDetails(request: Pokedex.PokemonDetailServiceModel.GetPokemonDetails.Request, completion: @escaping (Result<Pokedex.PokemonDetailServiceModel.GetPokemonDetails.Response, Error>) -> Void) {
        
        self.getPokemonDetailsCalled = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.getPokemonDetailsExpectation?.fulfill()
            
            switch self.configuration {
            case .sucess:
                
                MockHelper.mockData(
                    of: PokemonDetailServiceModel.GetPokemonDetails.Response.self,
                    fileName: "pokemon-details-get-pokemon-details",
                    fileExtension: "json") { result in
                        
                    completion(.success(result))
                }
                
            case .failure:
                completion(.failure(MockError.some))
            }
        }
        
    }
}

