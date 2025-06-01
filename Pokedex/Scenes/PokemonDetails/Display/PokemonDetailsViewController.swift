//
//  PokemonDetailsViewController.swift
//  Pokedex
//
//  Created by Felipe Martins on 01/06/25.
//

import UIKit

class PokemonDetailsViewController: BaseViewController {
    
    struct InputData {
        let itemId: Int
    }
    
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
    
    private lazy var pokemonDetailsView: PokemonDetailsView = {
        let detailsView = PokemonDetailsView()
        detailsView.translatesAutoresizingMaskIntoConstraints = false
        return detailsView
    }()
    
    private var interactor: PokemonDetailsInteractorProtocol?
    public var inputData: InputData = .init(itemId: 1)
    
    private func setupScene(){
        let presenter = PokemonDetailsPresenter(displayer: self)
        let service = PokemonDetailsService()
        //let service = PokemonDetailsServiceMock()
       // let service = PokemonDetailsServiceMock(configuration: .init(getPokemonDetailsConfiguration: .failure(PokemonDetailsServiceMock.MockError.someError)))
        let interactor = PokemonDetailsInteractor(inputData: .init(itemId: inputData.itemId), presenter: presenter, service: service)
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
    
    func displayPokemonDetails(viewModel: PokemonDetailsModels.PokemonDetails.ViewModel) {
        self.contentStackView.removeAllArrangedSubview()
        
        let name = viewModel.name
        let image = viewModel.image
        let types = viewModel.types
        let stats = viewModel.stats.compactMap{
            PokemonDetailsView.ViewRepresentation.Stat(title: $0.name, value: $0.value)
        }.filter{
            $0.title == "Hp" || $0.title == "Attack" || $0.title == "Defense" || $0.title == "Speed"
        }
        
        let viewRepresentation = PokemonDetailsView.ViewRepresentation(image: image, name: name, types: types, stats: stats)
        
        self.pokemonDetailsView.configureWith(viewRepresentation: viewRepresentation)
        
        self.contentStackView.addArrangedSubview(self.pokemonDetailsView)
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
    
    func configureViews() {
        self.view.backgroundColor = .systemBackground
    }
}

extension PokemonDetailsViewController: PKMDSEmptyStateViewDelegate {
    func buttonClicked(view: PKMDSEmptyStateView) {
        self.interactor?.startFlow(request: .init(isRetry: true))
    }
}
