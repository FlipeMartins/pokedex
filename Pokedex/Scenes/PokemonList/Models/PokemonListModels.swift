//
//  PokemonListModels.swift
//  Pokedex
//
//  Created by Felipe Martins on 29/05/25.
//

import Foundation

enum PokemonListModels {
    
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
        }
    }
    
    enum StartFlow {
        struct Request {}
        struct Response {}
        struct ViewModel {}
    }
    
    enum ShowItems {
        struct Request {}
        struct Response {
            struct ItemRepresentation {
                let name: String
            }
            
            let items: [ItemRepresentation]
        }
        struct ViewModel {
            struct ItemRepresentation {
                let name: String
            }
            
            let items: [ItemRepresentation]
        }
    }
    
    
    enum ShowDetails {
        struct Request {}
        struct Response {
            let itemId: Int
        }
        struct ViewModel {
            let itemId: Int
        }
    }
    
    enum UserSelectedItem {
        struct Request {
            let index: Int
        }
        struct Response {}
        struct ViewModel {}
    }
}
