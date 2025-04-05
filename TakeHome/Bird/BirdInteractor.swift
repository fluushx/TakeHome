//
//  BirdInteractor.swift
//  TakeHome
//
//  Created by Felipe I Zapata R on 03-04-25.

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
    func fetchBirdDataAsync() async throws -> [BirdModel] {
        let birds = try await (cloudDataSource).fetchBirdDataAsync()
        localDataSource.setBirdData(birds)
        return birds
    }
    func getBirdData() -> [BirdModel] {
        localDataSource.getBirdData()
    }
}
