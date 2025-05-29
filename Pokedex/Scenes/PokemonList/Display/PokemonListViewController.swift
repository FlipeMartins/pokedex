//
//  PokemonListViewController.swift
//  Pokedex
//
//  Created by Felipe Martins on 29/05/25.
//

import UIKit

class PokemonListViewController: UIViewController {
    
    private var interactor: PokemonListInteractorProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupScene()
    }
    
    private func setupScene(){
        let presenter = PokemonListPresenter(displayer: self)
        let service = PokemonListService()
        let interactor = PokemonListInteractor(presenter: presenter, serviceManager: service)
        self.interactor = interactor
    }
}

extension PokemonListViewController: PokemonListDisplayProtocol {
    
}
