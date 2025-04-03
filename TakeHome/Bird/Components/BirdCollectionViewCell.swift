//
//  BirdCollectionViewCell.swift
//  TakeHome
//
//  Created by Felipe I Zapata R on 03-04-25.
//

import UIKit

final class BirdCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "BirdCollectionViewCell"
    
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .blue
        return iv
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            titleLabel.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with bird: BirdModel) {
        guard let englishName = bird.englishName else {
            return
        }
        titleLabel.text = "\(englishName)"
        imageView.image = nil
        
//        // TODO: Cargar imagenes
//        if let url = bird.imageURL {
//            DispatchQueue.global().async {
//                if let data = try? Data(contentsOf: url),
//                   let image = UIImage(data: data) {
//                    DispatchQueue.main.async {
//                        self.imageView.image = image
//                    }
//                }
//            }
//        }
    }
}
