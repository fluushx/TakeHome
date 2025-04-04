//
//  BirdDetailViewCell.swift
//  TakeHome
//
//  Created by Felipe I Zapata R on 04-04-25.
//

import UIKit

// MARK: - BirdDetailViewCell
class BirdDetailViewCell: UITableViewCell {
    static let reuseIdentifier = "BirdDetailViewCell"
    
    // Container view que contendrá el label.
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 243/255, green: 243/255, blue: 243/255, alpha: 1)
        view.layer.cornerRadius = 8
        return view
    }()
    lazy var commentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implementado")
    }
    
    private func setupViews() {
        contentView.addSubview(containerView)
        containerView.addSubview(commentLabel)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 50),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -50),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            commentLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 14),
            commentLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            commentLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            commentLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -14)
        ])
    }
    
    func setUpLabel(comment: String) {
        commentLabel.text = comment
    }
}
