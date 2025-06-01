//
//  PokemonDetailsViewController.swift
//  Pokedex
//
//  Created by Felipe Martins on 01/06/25.
//

import Foundation

class PokemonDetailsViewController: BaseViewController {
    
    private var interactor: PokemonDetailsInteractorProtocol?
    
    private func setupScene(){
        let presenter = PokemonDetailsPresenter(displayer: self)
        let service = PokemonDetailsServiceMock() //PokemonDetailsService() (Change for Real Server When Implemented)
        let interactor = PokemonDetailsInteractor(presenter: presenter, service: service)
        self.interactor = interactor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupScene()
    }
    
}

extension PokemonDetailsViewController: PokemonDetailsDisplayProtocol {
    
   
}
