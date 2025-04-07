//
//  BirdDetailInteractor.swift
//  TakeHome
//
//  Created by Felipe I Zapata R on 03-04-25.

import UIKit

// MARK: - BirdDetailInteractor
final class BirdDetailInteractor: BirdDetailInteractorProtocol {
    var localDataSource: BirdDetailLocalDataSourceProtocol
    var cloudDataSource: BirdDetailCloudDataSourceProtocol

    // MARK: - Inits
    init(localDataSource: BirdDetailLocalDataSourceProtocol,
         cloudDataSource: BirdDetailCloudDataSourceProtocol) {
        self.localDataSource = localDataSource
        self.cloudDataSource = cloudDataSource
    }
}

// MARK: - BirdDetailPresenterInteractorProtocol
extension BirdDetailInteractor: BirdDetailPresenterInteractorProtocol {
    func fetchBirdNotes(id: String, completion: @escaping (Result<[Notes], Error>) -> Void) {
        cloudDataSource.fetchBirdNotes(id: id) { [weak self] noteResult in
            switch noteResult {
            case .success(let notes):
                _ = self?.localDataSource.updateBirdNotes(birdNotes: notes)
                completion(.success(notes))
            case .failure(let error):
                print("Error fetching notes: \(error)")
                completion(.failure(error))
            }
        }
    }

    func getBirdDetailData() -> BirDetailDisplayModel {
        localDataSource.getBirdDetailData()
    }
}
