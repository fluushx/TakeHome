//
//  AddNoteBirdViewController.swift
//  TakeHome
//
//  Created by Felipe I Zapata R on 04-04-25.
//  Copyright (c) 2025 Falabella FIF. All rights reserved.

import UIKit

// MARK: - AddNoteBirdViewController
final class AddNoteBirdViewController: UIViewController {
	var presenter: AddNoteBirdViewPresenterProtocol?
    
    let navBarView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Atrás", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTapBackAction), for: .touchUpInside)
        return button
    }()
}

// MARK: View Life Cycle
extension AddNoteBirdViewController {
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .green
        view.addSubview(navBarView)
        navBarView.addSubview(backButton)
        NSLayoutConstraint.activate([
            navBarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navBarView.heightAnchor.constraint(equalToConstant: 53),
            
            backButton.leadingAnchor.constraint(equalTo: navBarView.leadingAnchor, constant: 16),
            backButton.centerYAnchor.constraint(equalTo: navBarView.centerYAnchor)
        ])
    }
    @objc func didTapBackAction() {
        presenter?.dismissModule()
    }
}

// MARK: AddNoteBirdViewProtocol
extension AddNoteBirdViewController: AddNoteBirdViewProtocol {
}
