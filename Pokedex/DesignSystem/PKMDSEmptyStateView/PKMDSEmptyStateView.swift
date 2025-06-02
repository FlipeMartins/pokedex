//
//  PKMDSEmptyStateView.swift
//  Pokedex
//
//  Created by Felipe Martins on 31/05/25.
//

import UIKit

protocol PKMDSEmptyStateViewDelegate: AnyObject {
    func buttonClicked(view: PKMDSEmptyStateView)
}

class PKMDSEmptyStateView: UIView {
    
    private lazy var baseView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton(type: .system)

        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        
        return button
    }()
    
    public var title: String? {
        get {
            self.titleLabel.text
        }
        
        set {
            self.titleLabel.text = newValue
        }
    }
    
    public var message: String? {
        get {
            self.messageLabel.text
        }
        
        set {
            self.messageLabel.text = newValue
        }
    }
    
    public var buttonTitle: String? {
        get {
            self.button.title(for: .normal)
        }
        
        set {
            self.button.setTitle(newValue, for: .normal)
        }
    }
    
    public var image: PKMDSImage? {
        didSet {
            self.imageView.setPKMDSImage(image)
        }
    }

    public weak var delegate: PKMDSEmptyStateViewDelegate?
    
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
    
    @objc
    private func buttonClicked() {
        self.delegate?.buttonClicked(view: self)
    }
    
}

extension PKMDSEmptyStateView: PKMDSViewConfiguration {
    func buildViewHierarchy() {
        self.addSubview(baseView)
        
        self.baseView.addSubview(contentStackView)
            
        contentStackView.addArrangedSubview(imageView)
        contentStackView.addArrangedSubview(titleLabel)
        contentStackView.addArrangedSubview(messageLabel)
        contentStackView.addArrangedSubview(button)
        
    }
    
    func setupConstraints() {
        // ImageView
        NSLayoutConstraint.activate([
            self.imageView.heightAnchor.constraint(lessThanOrEqualToConstant: 200),
            self.imageView.widthAnchor.constraint(lessThanOrEqualToConstant: 200)
        ])
        
        // BaseView
        
        NSLayoutConstraint.activate([
            self.baseView.topAnchor.constraint(equalTo: self.topAnchor),
            self.baseView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.baseView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.baseView.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        ])
        
        // Content Stack 
        
        NSLayoutConstraint.activate([
            
            self.contentStackView.topAnchor.constraint(greaterThanOrEqualTo: self.baseView.topAnchor, constant: 8),
            self.contentStackView.bottomAnchor.constraint(lessThanOrEqualTo: self.baseView.bottomAnchor, constant: -8),
            self.contentStackView.leadingAnchor.constraint(greaterThanOrEqualTo: self.baseView.leadingAnchor, constant: 8),
            self.contentStackView.trailingAnchor.constraint(lessThanOrEqualTo: self.baseView.trailingAnchor, constant: -8),
            
            self.contentStackView.centerXAnchor.constraint(equalTo: self.baseView.centerXAnchor),
            self.contentStackView.centerYAnchor.constraint(equalTo: self.baseView.centerYAnchor)
        ])
    }
}
