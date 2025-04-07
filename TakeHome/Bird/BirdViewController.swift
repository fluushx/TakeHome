//
//  BirdViewController.swift
//  TakeHome
//
//  Created by Felipe I Zapata R on 03-04-25.

import UIKit

// MARK: - BirdViewController
final class BirdViewController: UIViewController {
    var data = [BirdDisplayModel]()
	var presenter: BirdViewPresenterProtocol?
    lazy var searchController: UISearchController = {
        let sc = UISearchController(searchResultsController: nil)
        sc.searchResultsUpdater = self
        sc.obscuresBackgroundDuringPresentation = false
        sc.searchBar.delegate = self
        sc.searchBar.placeholder = "Search"
        
        sc.searchBar.backgroundImage = UIImage()
        sc.searchBar.isTranslucent = true
        sc.searchBar.barTintColor = .clear
        sc.searchBar.backgroundColor = .clear
        sc.searchBar.isHidden = true
        return sc
    }()
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 196, height: 196)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(BirdCollectionViewCell.self, forCellWithReuseIdentifier: BirdCollectionViewCell.reuseIdentifier)
        return cv
    }()
    lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        return indicator
    }()
    lazy var loadingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Loading images..."
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .gray
        label.textAlignment = .center
        return label
    }()
    lazy var loadingContainerView: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.backgroundColor = .clear
        
        container.addSubview(activityIndicator)
        container.addSubview(loadingLabel)
        
        NSLayoutConstraint.activate([
            activityIndicator.topAnchor.constraint(equalTo: container.topAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            loadingLabel.topAnchor.constraint(equalTo: activityIndicator.bottomAnchor, constant: 10),
            loadingLabel.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            loadingLabel.bottomAnchor.constraint(equalTo: container.bottomAnchor)
        ])
        return container
    }()
}

// MARK: View Life Cycle
extension BirdViewController {
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .red
        setupSearchController()
        view.addSubview(collectionView)
        view.addSubview(loadingContainerView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            loadingContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        collectionView.dataSource = self
        collectionView.delegate = self
        fetchBirdData()
    }
    func fetchBirdData() {
        presenter?.fetchBirdData()
    }
    
}

// MARK: BirdViewProtocol
extension BirdViewController: BirdViewProtocol {
    func showError() {
        DispatchQueue.main.async {
            let errorView = GenericErrorView(frame: self.view.bounds)
            errorView.updateErrorMessage("An error occurred while fetching data.\n Please try again.")
            errorView.retryAction = { [weak self] in
                errorView.removeFromSuperview()
                self?.fetchBirdData()
            }
            self.view.addSubview(errorView)
            errorView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                errorView.topAnchor.constraint(equalTo: self.view.topAnchor),
                errorView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                errorView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                errorView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
            ])
        }
    }
    func showLoading() {
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
            self.loadingContainerView.isHidden = false
        }
    }
    func hideLoading() {
        DispatchQueue.main.async {
            self.searchController.searchBar.isHidden = false
            self.activityIndicator.stopAnimating()
            self.loadingContainerView.isHidden = true
            self.collectionView.reloadData()
        }
    }
    func updateBirdsDisplay(with birds: [BirdDisplayModel]) {
        self.data = birds
    }
}
