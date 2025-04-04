//
//  BirdDetailInteractor.swift
//  TakeHome
//
//  Created by Felipe I Zapata R on 03-04-25.
//  Copyright (c) 2025 Falabella FIF. All rights reserved.

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
    func getNotes() -> [Note] {
        localDataSource.getNotes()
    }
}
