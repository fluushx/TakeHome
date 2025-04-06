//
//  BirdInteractor.swift
//  TakeHome
//
//  Created by Felipe I Zapata R on 03-04-25.

import Foundation
import UIKit

// MARK: - BirdInteractor
final class BirdInteractor: BirdInteractorProtocol {
    var localDataSource: BirdLocalDataSourceProtocol
    var cloudDataSource: BirdCloudDataSourceProtocol

    // MARK: - Inits
    init(localDataSource: BirdLocalDataSourceProtocol,
         cloudDataSource: BirdCloudDataSourceProtocol) {
        self.localDataSource = localDataSource
        self.cloudDataSource = cloudDataSource
    }
}

// MARK: - BirdPresenterInteractorProtocol
extension BirdInteractor: BirdPresenterInteractorProtocol {
    private func processBatch(from index: Int,
                              birds: [BirdDisplayModel],
                              batchSize: Int,
                              onBatch: @escaping ([BirdDisplayModel]) -> Void,
                              completion: @escaping ([BirdDisplayModel]) -> Void) {
        var mutableBirds = birds
        let endIndex = min(index + batchSize, mutableBirds.count)
        let group = DispatchGroup()
        
        for i in index..<endIndex {
            group.enter()
            if let imageURL = mutableBirds[i].imageURL {
                cloudDataSource.downloadImage(for: imageURL) { image in
                    if let image = image {
                        mutableBirds[i].image = image
                        mutableBirds[i].isImageLoaded = true
                    } else {
                        mutableBirds[i].image = UIImage(named: "placeholder") ?? UIImage()
                        mutableBirds[i].isImageLoaded = false
                    }
                    group.leave()
                }
            } else {
                group.leave()
            }
        }
        
        group.notify(queue: DispatchQueue.main) {
            onBatch(mutableBirds)
            if endIndex < mutableBirds.count {
                self.processBatch(from: endIndex,
                                  birds: mutableBirds,
                                  batchSize: batchSize,
                                  onBatch: onBatch,
                                  completion: completion)
            } else {
                completion(mutableBirds)
            }
        }
    }
    
    func fetchBirdDataWithImages(onBatch: @escaping ([BirdDisplayModel]) -> Void,
                                 completion: @escaping ([BirdDisplayModel]) -> Void) {
        cloudDataSource.fetchBirdData { result in
            switch result {
            case .success(let birds):
                self.processBatch(from: 0,
                                  birds: birds,
                                  batchSize: 10,
                                  onBatch: onBatch) { [weak self] _ in
                    self?.localDataSource.setBirdData(birds)
                    completion(birds)
                }
            case .failure(let error):
                print("Error fetching birds: \(error)")
                completion([])
            }
        }
    }
    func getBirdData() -> [BirdDisplayModel] {
        localDataSource.getBirdData()
    }
}
