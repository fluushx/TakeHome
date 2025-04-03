//
//  BirdInteractor.swift
//  TakeHome
//
//  Created by Felipe I Zapata R on 03-04-25.
//  Copyright (c) 2025 Falabella FIF. All rights reserved.

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
}
