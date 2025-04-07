//
//  BirdViewController.swift
//  TakeHome
//
//  Created by Felipe I Zapata R on 03-04-25.

import UIKit

// MARK: - BirdViewController
final class BirdViewController: UIViewController {
    var data = [BirdDisplayModel]()
    var allBirds = [BirdDisplayModel]()
    var presenter: BirdViewPresenterProtocol?
    
    lazy var searchController: UISearchController = {
        let sc = UISearchController(searchResultsController: nil)
        // searchResultsUpdater is declared as weak, so self is not strongly captured.
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
    
    lazy var loadingContainerView: GenericLoadingIndicatorView = {
        let view = GenericLoadingIndicatorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()
    
    lazy var refreshControl: UIRefreshControl = {
        let rc = UIRefreshControl()
        rc.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        return rc
    }()
    lazy var noMatchesLabel: UILabel = {
        let label = UILabel()
        label.text = "No matches found"
        label.textAlignment = .center
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 16)
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
}

// MARK: - View Life Cycle
extension BirdViewController {
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
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
        collectionView.refreshControl = refreshControl
        fetchBirdData()
    }
    
    func fetchBirdData() {
        presenter?.fetchBirdData()
    }
    
    @objc func refreshData() {
        presenter?.fetchBirdData()
    }
}

// MARK: - BirdViewProtocol
extension BirdViewController: BirdViewProtocol {
    func showError() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.collectionView.isHidden = true
            self.searchController.searchBar.isHidden = true
            self.loadingContainerView.showRetry()
            self.loadingContainerView.updateMessage("Failed to complete action.\n Would you like to retry?")
            self.loadingContainerView.retryAction = { [weak self] in
                guard let self = self else { return }
                self.loadingContainerView.retryButton.isEnabled = true
                self.loadingContainerView.startLoading()
                self.loadingContainerView.updateMessage("Loading images...")
                self.fetchBirdData()
            }
        }
    }
    
    func showLoading() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            if self.collectionView.refreshControl?.isRefreshing == false {
                self.loadingContainerView.startLoading()
                self.loadingContainerView.isHidden = false
                self.loadingContainerView.updateMessage("Loading images...")
            }
        }
    }
    
    func hideLoading() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.searchController.searchBar.isHidden = false
            self.loadingContainerView.stopLoading()
            self.loadingContainerView.isHidden = true
            self.collectionView.isHidden = false
            if self.collectionView.refreshControl?.isRefreshing == true {
                self.collectionView.refreshControl?.endRefreshing()
            }
            self.collectionView.reloadData()
        }
    }
    
    func updateBirdsDisplay(with birds: [BirdDisplayModel]) {
        self.allBirds = birds
        if let searchText = searchController.searchBar.text, !searchText.isEmpty {
            self.data = allBirds.filter { bird in
                return bird.englishName?.localizedCaseInsensitiveContains(searchText) ?? false
            }
        } else {
            self.data = allBirds
        }
    }
}
