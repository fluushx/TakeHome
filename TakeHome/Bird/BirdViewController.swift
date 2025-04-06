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
    private lazy var searchController: UISearchController = {
        let sc = UISearchController(searchResultsController: nil)
        sc.searchResultsUpdater = self
        sc.obscuresBackgroundDuringPresentation = false
        sc.searchBar.delegate = self
        sc.searchBar.placeholder = "Search"
        
        // Personalización para que la searchBar sea transparente
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
}

// MARK: View Life Cycle
extension BirdViewController {
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .red
        setupSearchController()
        view.addSubview(collectionView)
        view.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        collectionView.dataSource = self
        collectionView.delegate = self
        fetchBirdData()
    }
    func fetchBirdData() {
        presenter?.fetchBirdData()
    }
    
}
// MARK: - UICollectionViewDataSource & Delegate
extension BirdViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: BirdCollectionViewCell.reuseIdentifier,
            for: indexPath
        ) as? BirdCollectionViewCell else {
            fatalError("No se pudo dequeuar BirdCollectionViewCell")
        }
        let bird = data[indexPath.item]
        cell.configure(with: bird)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedBird = data[indexPath.item]
        presenter?.didSelectBird(selectedBird)
    }
    
}
extension BirdViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = collectionView.bounds.width / 2
        return CGSize(width: cellWidth, height: 196)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

// MARK: BirdViewProtocol
extension BirdViewController: BirdViewProtocol {
    func showError() {
        print("showError")
    }
    func showLoading() {
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
        }
    }
    func hideLoading() {
        DispatchQueue.main.async {
            self.searchController.searchBar.isHidden = false
            self.activityIndicator.stopAnimating()
            self.collectionView.reloadData()
        }
    }
    func updateBirdsDisplay(with birds: [BirdDisplayModel]) {
           self.data = birds
       }
}

extension BirdViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func setupSearchController() {
        if let searchTextField = searchController.searchBar.value(forKey: "searchField") as? UITextField {
            searchTextField.backgroundColor = UIColor(white: 1, alpha: 0.3)
            searchTextField.alpha = 0.8
            searchTextField.layer.cornerRadius = 10
            searchTextField.clipsToBounds = true
        }
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        filterContentForSearchText(searchText)
    }
    
    func filterContentForSearchText(_ searchText: String) {
        if searchText.isEmpty {
            data = presenter?.getBirdData() ?? []
        } else {
            data = presenter?.getBirdData().filter { bird in
                let englishMatch = bird.englishName?.localizedCaseInsensitiveContains(searchText) ?? false
                let latinMatch = bird.latinName?.localizedCaseInsensitiveContains(searchText) ?? false
                return englishMatch || latinMatch
            } ?? []
        }
        collectionView.reloadData()
    }
}

