//
//  ErrorBirdDetailViewCell.swift
//  TakeHome
//
//  Created by Felipe I Zapata R on 07-04-25.
//

import Foundation
import UIKit

final class ErrorBirdDetailViewCell: UITableViewCell {
    static let reuseIdentifier = "ErrorTableViewCell"
    
    // We'll use a generic loading indicator view to show error and loading states.
    private lazy var loadingIndicatorView: GenericLoadingIndicatorView = {
        let view = GenericLoadingIndicatorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // Closure to trigger a retry action
    private var retryAction: (() -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupViews()
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func setupViews() {
        contentView.addSubview(loadingIndicatorView)
        
        NSLayoutConstraint.activate([
            loadingIndicatorView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            loadingIndicatorView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            loadingIndicatorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            loadingIndicatorView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
        
        // Assign the internal retry action of the generic view to call our local method.
        loadingIndicatorView.retryAction = { [weak self] in
            self?.handleRetry()
        }
    }
    
    /// Configures the cell to show an error state.
    /// - Parameter retryAction: Closure to execute when user taps Retry.
    func configureErrorState(retryAction: @escaping () -> Void) {
        self.retryAction = retryAction
        // Set the state to retry: message is "Could not load comments. Retry?"
        loadingIndicatorView.state = .retry
    }
    
    private func handleRetry() {
        // When retry is tapped, hide the button and show the indicator with "Loading comments..."
        loadingIndicatorView.state = .loading
        loadingIndicatorView.updateMessage("Loading comments...")
        // Execute the external retry action
        retryAction?()
        
        // After 3 seconds, revert to error state if not updated by success.
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) { [weak self] in
            guard let self = self else { return }
            // Check if state is still loading; if yes, revert to retry.
            if self.loadingIndicatorView.state == .loading {
                self.loadingIndicatorView.state = .retry
            }
        }
    }
}
