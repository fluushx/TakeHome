//
//  BirdDetailHeaderView.swift
//  TakeHome
//
//  Created by Felipe I Zapata R on 04-04-25.
//

import Foundation
import UIKit

// MARK: - BirdDetailHeaderProtocol
protocol BirdDetailHeaderProtocol {
    func configure(with image: UIImage)
}

// MARK: - BirdDetailHeaderView
final class BirdDetailHeaderView: UIView, BirdDetailHeaderProtocol{
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .blue
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Community Notes"
        label.numberOfLines = 0
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var imageHeightConstraint: NSLayoutConstraint!
    var imageWidthConstraint: NSLayoutConstraint!
    
    private let maxImageHeight: CGFloat = 289
    private let maxImageWidth: CGFloat = 273
    private let minImageHeight: CGFloat = 133
    private let minImageWidth: CGFloat = 127
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implementado")
    }
    
    private func setupViews() {
        addSubview(imageView)
        addSubview(subtitleLabel)
        
        imageHeightConstraint = imageView.heightAnchor.constraint(equalToConstant: maxImageHeight)
        imageWidthConstraint = imageView.widthAnchor.constraint(equalToConstant: maxImageWidth)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageHeightConstraint,
            imageWidthConstraint,
            
            subtitleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            subtitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50),
            subtitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50),
            subtitleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }
    
    /// Updates the image size according to the scroll offset.
    func updateImageSize(scrollOffset: CGFloat) {
        let newHeight = max(maxImageHeight - scrollOffset, minImageHeight)
        //The new high is calculated, without going below the minimum.
        let ratio = (maxImageWidth - minImageWidth) / (maxImageHeight - minImageHeight)
        let newWidth = max(maxImageWidth - scrollOffset * ratio, minImageWidth)
        
        imageHeightConstraint.constant = newHeight
        imageWidthConstraint.constant = newWidth
        //Forced layout update
        layoutIfNeeded()
    }
    
    /// Returns the desired total header height based on the current content.
    func currentHeight() -> CGFloat {
        let topMargin: CGFloat = 16
        let spacing: CGFloat = 16
        let bottomMargin: CGFloat = 16
        let subtitleHeight = subtitleLabel.intrinsicContentSize.height
        let currentImageHeight = imageHeightConstraint.constant
        return topMargin + currentImageHeight + spacing + subtitleHeight + bottomMargin
    }
    func configure(with image: UIImage) {
        imageView.image = image
    }
}
