//
//  BaseViewController.swift
//  Pokedex
//
//  Created by Felipe Martins on 01/06/25.
//

import UIKit

class BaseViewController: UIViewController {
    
    private var loadingView: UIView?
    
    func startLoading() {
        // Se já estiver carregando, não adiciona outra
        guard loadingView == nil else { return }

        let overlay = UIView()
        overlay.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        overlay.translatesAutoresizingMaskIntoConstraints = false
        
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.color = .white
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()

        overlay.addSubview(spinner)
        view.addSubview(overlay)

        NSLayoutConstraint.activate([
            overlay.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            overlay.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            overlay.topAnchor.constraint(equalTo: view.topAnchor),
            overlay.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            spinner.centerXAnchor.constraint(equalTo: overlay.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: overlay.centerYAnchor)
        ])

        loadingView = overlay
        view.bringSubviewToFront(overlay)
    }
    
    func stopLoading() {
        loadingView?.removeFromSuperview()
        loadingView = nil
    }
    
}
