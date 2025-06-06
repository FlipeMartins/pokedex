//
//  PokemonDetailsModels.swift
//  Pokedex
//
//  Created by Felipe Martins on 01/06/25.
//

import Foundation

enum PokemonDetailsModels {
    
    enum StartLoading {

        struct Request {}
        struct Response {}
        struct ViewModel {}
    }

    enum StopLoading {

        struct Request {}
        struct Response {}
        struct ViewModel {}
    }
    
    enum EmptyState {
        struct Request {}
        struct Response {}
        struct ViewModel {
            let alertTitle: String
            let alertMessage: String
            let image: PKMDSImage?
            let buttonTitle: String
        }
    }
    
    enum StartFlow {
        struct Request {
            let isRetry: Bool
            
            init(isRetry: Bool = false){
                self.isRetry = isRetry
            }
        }
        struct Response {}
        struct ViewModel {}
    }
    
    enum PokemonDetails {
        struct Request {}
        struct Response {
            struct Stat {
                let name: String
                let value: Int
            }
            
            let name: String
            let image: PKMDSImage
            let types: [String]
            let stats: [Stat]
        }
        struct ViewModel {
            struct Stat {
                let name: String
                let value: String
            }
            
            let name: String
            let image: PKMDSImage
            let types: [String]
            let stats: [Stat]
        }
    }
    
}
