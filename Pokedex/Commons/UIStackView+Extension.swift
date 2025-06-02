//
//  UIStackView+Extension.swift
//  Pokedex
//
//  Created by Felipe Martins on 31/05/25.
//

import UIKit

extension UIStackView {
    func removeAllArrangedSubview() {
        subviews.forEach({ $0.removeFromSuperview() })
    }
}
