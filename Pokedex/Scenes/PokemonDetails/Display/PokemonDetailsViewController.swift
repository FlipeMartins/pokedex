//
//  PokemonDetailsViewController.swift
//  Pokedex
//
//  Created by Felipe Martins on 01/06/25.
//

import UIKit

class PokemonDetailsViewController: BaseViewController {
    
    private var contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var emptyStateView: PKMDSEmptyStateView = {
        let view = PKMDSEmptyStateView()
        view.delegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var interactor: PokemonDetailsInteractorProtocol?
    
    private func setupScene(){
        let presenter = PokemonDetailsPresenter(displayer: self)
        let service = PokemonDetailsServiceMock() //PokemonDetailsService() (Change for Real Server When Implemented)
        let interactor = PokemonDetailsInteractor(presenter: presenter, service: service)
        self.interactor = interactor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buildLayout()

        setupScene()
        self.interactor?.startFlow(request: .init())
    }
    
}

extension PokemonDetailsViewController: PokemonDetailsDisplayProtocol {
    
    func displayStartLoading(viewModel: PokemonDetailsModels.StartLoading.ViewModel) {
        self.startLoading()
    }
    
    func displayStopLoading(viewModel: PokemonDetailsModels.StopLoading.ViewModel) {
        self.stopLoading()
    }
    
    func displayEmptyState(viewModel: PokemonDetailsModels.EmptyState.ViewModel) {
        
        self.contentStackView.removeAllArrangedSubview()
        
        self.emptyStateView.title = viewModel.alertTitle
        self.emptyStateView.message = viewModel.alertMessage
        self.emptyStateView.image = viewModel.image
        self.emptyStateView.buttonTitle = viewModel.buttonTitle
        
        self.contentStackView.addArrangedSubview(self.emptyStateView)
    }
}

extension PokemonDetailsViewController: PKMDSViewConfiguration {
    
    func buildViewHierarchy() {
        self.view.addSubview(contentStackView)
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            self.contentStackView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.contentStackView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.contentStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.contentStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
            
        ])
    }
}

extension PokemonDetailsViewController: PKMDSEmptyStateViewDelegate {
    func buttonClicked(view: PKMDSEmptyStateView) {
        self.interactor?.startFlow(request: .init(isRetry: true))
    }
}
