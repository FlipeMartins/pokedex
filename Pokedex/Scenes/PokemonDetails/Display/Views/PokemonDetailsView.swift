//
//  PokemonDetailsView.swift
//  Pokedex
//
//  Created by Felipe Martins on 01/06/25.
//

import UIKit

class PokemonDetailsView: UIView {
    
    struct ViewRepresentation {
        
        struct Stat {
            let title: String
            let value: String
        }
        
        let image: PKMDSImage
        let name: String
        let types: [String]
        let stats: [Stat]
    }
    
    private lazy var baseView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var contentStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.backgroundColor = UIColor.lightGray // TODO: Remove
        
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = .init(top: 20.0,
                                        left: 8.0,
                                    bottom: 8.0,
                                    right: 8.0)
        
        
        return stackView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var typesContentStack: UIStackView = {
        
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 20.0
        
        return stackView
    }()
    
    private lazy var statsContentStack: UIStackView = {
        
        let stackView = UIStackView()
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 10.0
        stackView.axis = .vertical
        return stackView
    }()
    
    public init(){
        super.init(frame: CGRect.zero)
        buildLayout()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        buildLayout()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        buildLayout()
    }
    
    public func configureWith(viewRepresentation: ViewRepresentation) {
        self.imageView.setPKMDSImage(viewRepresentation.image)
        self.nameLabel.text = viewRepresentation.name
        
        viewRepresentation.types.forEach {
            
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = $0
            
            self.typesContentStack.addArrangedSubview(label)
        }
        
        viewRepresentation.stats.forEach {
            
            let stackview = UIStackView()
            stackview.translatesAutoresizingMaskIntoConstraints = false
            stackview.distribution = .fill
            stackview.spacing = 20.0
            
            let titleLabel = UILabel()
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            titleLabel.text = $0.title
            titleLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
            
            titleLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
            
            let valueLabel = UILabel()
            valueLabel.translatesAutoresizingMaskIntoConstraints = false
            valueLabel.text = $0.value
            
            stackview.addArrangedSubview(titleLabel)
            stackview.addArrangedSubview(valueLabel)
            
            self.statsContentStack.addArrangedSubview(stackview)
        }
        
        let spacerView = UIView()
        self.statsContentStack.addArrangedSubview(spacerView)
    }
    
}


extension PokemonDetailsView: PKMDSViewConfiguration {
    func buildViewHierarchy() {
        self.addSubview(self.baseView)
        self.baseView.addSubview(contentStack)
        self.baseView.addSubview(imageView)
        
        //
        self.contentStack.addArrangedSubview(nameLabel)
        self.contentStack.addArrangedSubview(typesContentStack)
        
        let spacerView = UIView()
        self.contentStack.addArrangedSubview(spacerView)
        
        self.contentStack.addArrangedSubview(statsContentStack)
        
    }
    
    func setupConstraints() {
    
        // BaseView
        NSLayoutConstraint.activate([
            self.baseView.topAnchor.constraint(equalTo: self.topAnchor),
            self.baseView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.baseView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.baseView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
        ])
        
        // Base Content
        NSLayoutConstraint.activate([
            self.contentStack.topAnchor.constraint(equalTo: self.baseView.topAnchor, constant: 300),
            self.contentStack.trailingAnchor.constraint(equalTo: self.baseView.trailingAnchor),
            self.contentStack.bottomAnchor.constraint(equalTo: self.baseView.bottomAnchor),
            self.contentStack.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor),
        ])
        
        // Image
        
        NSLayoutConstraint.activate([
            self.imageView.heightAnchor.constraint(equalToConstant: 150),
            self.imageView.widthAnchor.constraint(equalToConstant: 150),
            
            self.imageView.centerXAnchor.constraint(equalTo: contentStack.centerXAnchor),
            
            self.imageView.bottomAnchor.constraint(equalTo: contentStack.topAnchor, constant: 20)
        
        ])
        
        // Name Label
        NSLayoutConstraint.activate([
            self.nameLabel.heightAnchor.constraint(equalToConstant: 40.0)
        ])
        
        // types Content Stav
        
        NSLayoutConstraint.activate([
            self.typesContentStack.heightAnchor.constraint(equalToConstant: 60.0)
        ])
        
    }
    
    func configureViews() {
        self.contentStack.layer.cornerRadius = 20
        self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        self.contentStack.clipsToBounds = true
    }
}
