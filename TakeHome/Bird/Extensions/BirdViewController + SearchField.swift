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
               data = allBirds
           } else {
               data = allBirds.filter { bird in
                   let englishMatch = bird.englishName?.localizedCaseInsensitiveContains(searchText) ?? false
                   return englishMatch
               }
           }
           setupNoMatchesLabel()  // update or remove the label according to the result.
           collectionView.reloadData()
       }
    private func setupNoMatchesLabel() {
        if data.isEmpty {
            let label = UILabel()
            label.text = "No matches found"
            label.textAlignment = .center
            label.textColor = .gray
            label.font = UIFont.systemFont(ofSize: 16)
            label.numberOfLines = 0
            
            label.frame = collectionView.bounds
            label.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            collectionView.backgroundView = label
        } else {
            collectionView.backgroundView = nil
        }
    }
}

