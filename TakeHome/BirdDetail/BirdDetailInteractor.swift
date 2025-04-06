//
//  BirdDetailInteractor.swift
//  TakeHome
//
//  Created by Felipe I Zapata R on 03-04-25.

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
    func getBirdId() -> String {
        localDataSource.getBirdId()
    }
    
    func getNotes() -> [Notes] {
        localDataSource.getNotes()
    }
}
