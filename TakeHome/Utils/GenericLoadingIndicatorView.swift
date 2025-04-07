//
//  GenericLoadingIndicatorView.swift
//  TakeHome
//
//  Created by Felipe I Zapata R on 07-04-25.
//

import Foundation
import UIKit

enum LoadingIndicatorState {
    case loading
    case success
    case retry
}

final class GenericLoadingIndicatorView: UIView {
    
    // MARK: - Subviews
    private let indicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .medium)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.hidesWhenStopped = true
        return view
    }()
    
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    lazy var retryButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Retry", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(retryButtonTapped), for: .touchUpInside)
        button.isHidden = true
        return button
    }()
    
    // MARK: - Properties
    var state: LoadingIndicatorState = .loading {
        didSet {
            updateViewForState()
        }
    }
    
    /// Closure to execute when the retry button is tapped.
    var retryAction: (() -> Void)?
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        updateViewForState()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        backgroundColor = .clear
        
        addSubview(indicator)
        addSubview(messageLabel)
        addSubview(retryButton)
        
        NSLayoutConstraint.activate([
            indicator.topAnchor.constraint(equalTo: topAnchor),
            indicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            messageLabel.topAnchor.constraint(equalTo: indicator.bottomAnchor, constant: 8),
            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            messageLabel.heightAnchor.constraint(equalToConstant: 50.0),
            
            retryButton.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 10),
            retryButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            retryButton.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    // MARK: - Update UI for State
    private func updateViewForState() {
        switch state {
        case .loading:
            indicator.startAnimating()
            indicator.isHidden = false
            messageLabel.text = "Sending comment..."
            retryButton.isHidden = true
        case .success:
            indicator.stopAnimating()
            indicator.isHidden = true
            messageLabel.text = "Message sent successfully"
            retryButton.isHidden = true
        case .retry:
            indicator.stopAnimating()
            indicator.isHidden = true
            messageLabel.text = "Failed to complete action. Would you like to retry?"
            retryButton.isHidden = false
        }
    }
    
    // MARK: - Public Methods
    func startLoading() {
        state = .loading
        isHidden = false
    }
    
    func showSuccess() {
        state = .success
        isHidden = false
    }
    
    func showRetry() {
        state = .retry
        isHidden = false
    }
    
    func stopLoading() {
        isHidden = true
    }
    
    /// Updates the message displayed by the loading indicator.
    func updateMessage(_ newMessage: String) {
        messageLabel.text = newMessage
    }
    
    // MARK: - Actions
    @objc private func retryButtonTapped() {
        retryAction?()
    }
}
