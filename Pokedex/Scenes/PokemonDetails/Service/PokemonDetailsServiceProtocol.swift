//
//  PokemonDetailsServiceProtocol.swift
//  Pokedex
//
//  Created by Felipe Martins on 01/06/25.
//

import Foundation

enum PokemonDetailServiceModel {
    enum GetPokemonDetails {
        struct Request {
            let itemId: Int
        }
        struct Response: Decodable {
            
            private enum CodingKeys: String, CodingKey {
                case name
                case id
                case sprites
                case types
                case stats
            }
            
            struct Sprites: Decodable {
                
                struct Other: Decodable {
                    
                    private enum CodingKeys: String, CodingKey {
                        case officialArtwork = "official-artwork"
                    }
                    
                    struct OfficialArtwork: Decodable {
                        private enum CodingKeys: String, CodingKey {
                            case frontDefault = "front_default"
                        }
                        
                        let frontDefault: String
                    }
                    
                    let officialArtwork: OfficialArtwork
                    
                }
                
                let other: Other
                
            }
            
           struct TypeRepresentation: Decodable {
                
                struct PokemonType: Decodable {
                    let name: String
                }
                
                let slot: Int
                let type: PokemonType
            }
            
            struct StatRepresentation: Decodable {
                
                private enum CodingKeys: String, CodingKey {
                    case baseStat = "base_stat"
                    case stat
                }
                
                struct Stat: Decodable {
                    let name: String
                }
                
                let baseStat: Int
                let stat: Stat
                
            }
            
            let name: String
            let id: Int
            let sprites: Sprites
            let types: [TypeRepresentation]
            let stats: [StatRepresentation]
        }
    }
}

protocol PokemonDetailsServiceProtocol {
    func getPokemonDetails(request: PokemonDetailServiceModel.GetPokemonDetails.Request, completion: @escaping (Result<PokemonDetailServiceModel.GetPokemonDetails.Response, Error>) -> Void)
}
