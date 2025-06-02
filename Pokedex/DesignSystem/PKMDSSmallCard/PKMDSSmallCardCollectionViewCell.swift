//
//  PKMDSSmalCardCollectionViewCell.swift
//  Pokedex
//
//  Created by Felipe Martins on 30/05/25.
//

import UIKit

class PKMDSSmallCardCollectionViewCell: UICollectionViewCell {
    
    static var identifier: String {
        return String(describing: self)
    }
    
    private lazy var baseView: PKMDSSmallCard = {
        
        let smallCard = PKMDSSmallCard()
        smallCard.translatesAutoresizingMaskIntoConstraints = false
        return smallCard
    }()
    
    public var itemImage: PKMDSImage? {
        didSet {
            baseView.itemImage = itemImage
        }
    }
    
    public var title: String? {
        
        get {
            baseView.title
        }
        
        set {
            baseView.title = newValue
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
    
    override func prepareForReuse() {
        self.baseView.cancelImageDownload()
    }
}

extension PKMDSSmallCardCollectionViewCell: PKMDSViewConfiguration {
    
    func buildViewHierarchy() {
        self.addSubview(baseView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            self.baseView.topAnchor.constraint(equalTo: self.topAnchor),
            self.baseView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.baseView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.baseView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
    func configureViews() {
        self.layer.cornerRadius = 4.0
        self.layer.masksToBounds = true
    }
}
