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
        let interactor = PokemonListInteractor(presenter: presenter, service: service)
        self.interactor = interactor
    }
}

extension PokemonListViewController: PokemonListDisplayProtocol {
    func displayStartLoading(viewModel: PokemonListModels.StartLoading.ViewModel) {
        // Do Something
    }
    
    func displayStopLoading(viewModel: PokemonListModels.StopLoading.ViewModel) {
        // Do Something
    }
    
    func displayEmptyState(viewModel: PokemonListModels.EmptyState.ViewModel) {
        // Do Something
    }
    
    func displayShowItems(viewModel: PokemonListModels.ShowItems.ViewModel) {
        // Do Something
    }
    
    func displayShowDetails(viewModel: PokemonListModels.ShowDetails.ViewModel) {
        // Do Something
    }
    
    
}
