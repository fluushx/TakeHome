//
//  BirdDetailViewController.swift
//  TakeHome
//
//  Created by Felipe I Zapata R on 03-04-25.
//  Copyright (c) 2025 Falabella FIF. All rights reserved.

import UIKit

// MARK: - BirdDetailViewController
final class BirdDetailViewController: UIViewController {
    var presenter: BirdDetailViewPresenterProtocol?
    lazy var imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .blue
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    lazy var subTitleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textAlignment = .left
        titleLabel.numberOfLines = 0
        titleLabel.text = "Community Notes"
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [subTitleLabel, tableView])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    lazy var addNoteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Add Note", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleButtonTap), for: .touchUpInside)
        return button
    }()

}

// MARK: View Life Cycle
extension BirdDetailViewController {
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .yellow
        
        view.addSubview(imageView)
        view.addSubview(mainStackView)
        view.addSubview(addNoteButton)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            imageView.heightAnchor.constraint(equalToConstant: 306),
            imageView.widthAnchor.constraint(equalToConstant: 293),
            
            mainStackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 32),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
  
            addNoteButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            addNoteButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            addNoteButton.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            addNoteButton.heightAnchor.constraint(equalToConstant: 95)
            
        ])
    }
    @objc func handleButtonTap() {
        print("Botón presionado")
        presenter?.goToAddNote()
    }

}

// MARK: BirdDetailViewProtocol
extension BirdDetailViewController: BirdDetailViewProtocol {
}
