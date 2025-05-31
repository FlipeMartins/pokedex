//
//  PokemonListViewController.swift
//  Pokedex
//
//  Created by Felipe Martins on 29/05/25.
//

import UIKit

class PokemonListViewController: UIViewController {
    
    struct ItemRepresentation {
        let name: String
        let image: PKMDSImage
    }
    
    private struct CollectionViewInsetsMetrics {
        static let leadingSpace: CGFloat = 16.0
        static let trailingSpace: CGFloat = 16.0
        static let bottomSpace: CGFloat = 0
        static let topSpace: CGFloat = 0
    }
    
    private struct InsetsMetrics {
        static let minimumLineSpace: CGFloat = 8.0
        static let minimumInterItemSpace: CGFloat = 7.0
    }
    
    private lazy var collectionViewItems: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.contentInset = UIEdgeInsets(
            top: CollectionViewInsetsMetrics.topSpace,
            left: CollectionViewInsetsMetrics.leadingSpace,
            bottom: CollectionViewInsetsMetrics.bottomSpace,
            right: CollectionViewInsetsMetrics.trailingSpace
        )
        
        collectionView.register(PKMDSSmallCardCollectionViewCell.self, forCellWithReuseIdentifier: PKMDSSmallCardCollectionViewCell.identifier)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
        return collectionView
    }()
    
    var items: [ItemRepresentation] = []
    
    private var interactor: PokemonListInteractorProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        buildLayout()
        // Do any additional setup after loading the view.
        setupScene()
        self.interactor?.startFlow(request: .init())
    }
    
    private func setupScene(){
        let presenter = PokemonListPresenter(displayer: self)
        let service = PokemonListServiceMock() //PokemonListService() (Change for Real Server When Implemented)
        let interactor = PokemonListInteractor(presenter: presenter, service: service)
        self.interactor = interactor
    }
}

extension PokemonListViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
  
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PKMDSSmallCardCollectionViewCell.identifier, for: indexPath) as? PKMDSSmallCardCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let item = items[indexPath.item]
        cell.title = item.name
        cell.itemImage = item.image
        cell.backgroundColor = UIColor.lightGray
        
        return cell
    }
}


extension PokemonListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.interactor?.userSelectedItem(request: .init(index: indexPath.item))
    }
}

extension PokemonListViewController: UICollectionViewDelegateFlowLayout {
 
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let contentWidth = collectionView.frame.size.width - CollectionViewInsetsMetrics.leadingSpace - CollectionViewInsetsMetrics.trailingSpace
        let width = ((contentWidth - InsetsMetrics.minimumInterItemSpace) / 2)
        return CGSize(width: width, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return InsetsMetrics.minimumLineSpace
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return InsetsMetrics.minimumInterItemSpace    }
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
        self.items = viewModel.items.compactMap{ItemRepresentation(name: $0.name, image: $0.image)}
        self.collectionViewItems.reloadData()
    }
    
    func displayShowDetails(viewModel: PokemonListModels.ShowDetails.ViewModel) {
        // Do Something
    }
    
}

extension PokemonListViewController: PKMDSViewConfiguration {
    func buildViewHierarchy() {
        self.view.addSubview(self.collectionViewItems)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            self.collectionViewItems.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20),
            self.collectionViewItems.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -20),
            self.collectionViewItems.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            self.collectionViewItems.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20)
            
        ])
    }
}
