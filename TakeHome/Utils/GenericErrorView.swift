//
//  GenericErrorView.swift
//  TakeHome
//
//  Created by Felipe I Zapata R on 07-04-25.
//

import Foundation
import UIKit

final class GenericErrorView: UIView {
    
    // MARK: - Subviews
    
    private let errorImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "exclamationmark.triangle")
        imageView.tintColor = .red
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.text = "An error occurred. Please try again."
        label.textAlignment = .center
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let retryButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Retry", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // Closure to execute when retry is tapped.
    var retryAction: (() -> Void)?
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    private func setupViews() {
        backgroundColor = UIColor(white: 0.95, alpha: 1) // Light background color
        addSubview(errorImageView)
        addSubview(messageLabel)
        addSubview(retryButton)
        
        retryButton.addTarget(self, action: #selector(retryButtonTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            errorImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            errorImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            errorImageView.widthAnchor.constraint(equalToConstant: 50),
            errorImageView.heightAnchor.constraint(equalToConstant: 50),
            
            messageLabel.topAnchor.constraint(equalTo: errorImageView.bottomAnchor, constant: 10),
            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            retryButton.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 15),
            retryButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            retryButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -40)
        ])
    }
    
    // MARK: - Actions
    @objc private func retryButtonTapped() {
        retryAction?()
    }
    
    // MARK: - Public Methods
    func updateErrorMessage(_ message: String) {
        messageLabel.text = message
    }
}
