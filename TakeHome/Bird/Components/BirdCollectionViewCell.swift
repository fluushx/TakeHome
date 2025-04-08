//
//  BirdCollectionViewCell.swift
//  TakeHome
//
//  Created by Felipe I Zapata R on 03-04-25.
//

import UIKit
protocol BirdCollectionViewCellProtocol {
    func showLoading()
    func hideLoading()
    func configure(with bird: BirdDisplayModel)
}

final class BirdCollectionViewCell: UICollectionViewCell, BirdCollectionViewCellProtocol {
    static let reuseIdentifier = "BirdCollectionViewCell"
    
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .blue
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.isHidden = true

        return iv
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = true
        label.textColor = .white
        label.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
        label.layer.cornerRadius = 10
        label.clipsToBounds = true   
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 50),
            
            activityIndicator.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with bird: BirdDisplayModel) {
        guard let englishName = bird.englishName else {
            return
        }
        titleLabel.text = "\(englishName)"
    
        if bird.isImageLoaded {
            imageView.image = bird.image
            hideLoading()
        } else {
            showLoading()
        }
    }
}

extension BirdCollectionViewCell {
    func showLoading() {
        activityIndicator.startAnimating()

    }
    func hideLoading() {
        titleLabel.isHidden = false
        imageView.isHidden = false
        activityIndicator.stopAnimating()
    }
}
