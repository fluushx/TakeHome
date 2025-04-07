//
//  BirdViewController.swift
//  TakeHome
//
//  Created by Felipe I Zapata R on 07-04-25.
//

import Foundation
import UIKit

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
            fatalError("Error finding BirdCollectionViewCell")
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

