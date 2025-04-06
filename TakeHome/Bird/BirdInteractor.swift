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
        // Creamos una copia mutable del array para poder actualizarla
        var mutableBirds = birds
        let endIndex = min(index + batchSize, mutableBirds.count)
        let group = DispatchGroup()
        
        for i in index..<endIndex {
            group.enter()
            if let imageURL = mutableBirds[i].imageURL {
                cloudDataSource.downloadImage(for: imageURL) { image in
                    mutableBirds[i].image = image ?? UIImage() // Asigna un placeholder si falla
                    group.leave()
                }
            } else {
                group.leave()
            }
        }
        
        group.notify(queue: DispatchQueue.main) {
            // Notifica con el array actualizado hasta ahora
            onBatch(mutableBirds)
            if endIndex < mutableBirds.count {
                // Procesamos el siguiente lote
                self.processBatch(from: endIndex,
                                  birds: mutableBirds,
                                  batchSize: batchSize,
                                  onBatch: onBatch,
                                  completion: completion)
            } else {
                // Se completó la descarga de todos los lotes
                completion(mutableBirds)
            }
        }
    }
        
        // Función pública que descarga datos y procesa las imágenes en lotes
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
