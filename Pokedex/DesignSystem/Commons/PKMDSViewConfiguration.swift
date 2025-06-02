//
//  PKMDSViewConfiguration.swift
//  Pokedex
//
//  Created by Felipe Martins on 30/05/25.
//

import UIKit

public protocol PKMDSViewConfiguration: AnyObject {
    func buildViewHierarchy()
    func setupConstraints()
    func configureViews()
    func buildLayout()
}

extension PKMDSViewConfiguration {
    public func buildLayout(){
        buildViewHierarchy()
        setupConstraints()
        configureViews()
    }

    public func configureViews() {}
}
