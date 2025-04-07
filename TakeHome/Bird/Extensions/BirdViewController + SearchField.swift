//
//  BirdViewController + SearchField.swift
//  TakeHome
//
//  Created by Felipe I Zapata R on 07-04-25.
//

import Foundation
import UIKit

// MARK: - UISearchBar & Delegate
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

