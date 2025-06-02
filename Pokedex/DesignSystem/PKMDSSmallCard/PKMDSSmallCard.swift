//
//  PKMDSSmallCard.swift
//  Pokedex
//
//  Created by Felipe Martins on 30/05/25.
//

import UIKit

class PKMDSSmallCard: UIView {
    
    private lazy var baseView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var itemImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var backgroundItemImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
 
    public var itemImage: PKMDSImage? {
        didSet {
            itemImageView.setPKMDSImage(itemImage)
        }
    }
    
    public var title: String? {
        
        get {
            self.titleLabel.text
        }
        
        set {
            self.titleLabel.text = newValue
        }
    }
    
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
    
    public func cancelImageDownload() {
        self.itemImageView.cancelImageDownload()
    }
    
}

extension PKMDSSmallCard: PKMDSViewConfiguration {
    
    func buildViewHierarchy() {
        self.addSubview(baseView)
        
        self.baseView.addSubview(titleLabel)
        self.baseView.addSubview(itemImageView)
        
        
    }
    
    func setupConstraints() {
        
        // Base View
        NSLayoutConstraint.activate([
            self.baseView.topAnchor.constraint(equalTo: self.topAnchor, constant: 4.0),
            self.baseView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -4.0),
            self.baseView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 4.0),
            self.baseView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -4.0)
        ])
        
        // TitleLabel
        
        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: self.baseView.topAnchor, constant: 8.0),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.baseView.leadingAnchor),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.baseView.trailingAnchor),
            self.titleLabel.heightAnchor.constraint(equalToConstant: 12.0)
        ])
        
        // ItemImageView
        
        NSLayoutConstraint.activate([
            self.itemImageView.topAnchor.constraint(greaterThanOrEqualTo: self.titleLabel.bottomAnchor, constant: 2.0),
            self.itemImageView.bottomAnchor.constraint(lessThanOrEqualTo: self.baseView.bottomAnchor, constant: 2.0),
            self.itemImageView.heightAnchor.constraint(equalToConstant: 50.0),
            self.itemImageView.widthAnchor.constraint(equalToConstant: 50.0),
            self.itemImageView.centerXAnchor.constraint(equalTo: self.baseView.centerXAnchor),
            self.itemImageView.centerYAnchor.constraint(equalTo: self.baseView.centerYAnchor)
        ])
    }
    
    func configureViews() {
        self.layer.cornerRadius = 4.0
        self.layer.masksToBounds = true
    }
}


