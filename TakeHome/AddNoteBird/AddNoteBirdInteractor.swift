//
//  AddNoteBirdInteractor.swift
//  TakeHome
//
//  Created by Felipe I Zapata R on 04-04-25.
//  Copyright (c) 2025 Falabella FIF. All rights reserved.

import Foundation

// MARK: - AddNoteBirdInteractor
final class AddNoteBirdInteractor: AddNoteBirdInteractorProtocol {
    var localDataSource: AddNoteBirdLocalDataSourceProtocol
    var cloudDataSource: AddNoteBirdCloudDataSourceProtocol

    // MARK: - Inits
    init(localDataSource: AddNoteBirdLocalDataSourceProtocol,
         cloudDataSource: AddNoteBirdCloudDataSourceProtocol) {
        self.localDataSource = localDataSource
        self.cloudDataSource = cloudDataSource
    }
}

// MARK: - AddNoteBirdPresenterInteractorProtocol
extension AddNoteBirdInteractor: AddNoteBirdPresenterInteractorProtocol {
    func callAddNoteBirdAsync(birdId: String, comment: String) async throws -> Bool {
       let addNoteSuccess = try await cloudDataSource.callAddNoteBirdAsync(birdId: birdId, comment: comment, timestamp: 1)
        return addNoteSuccess
    }
    func getBirdId() -> String {
        localDataSource.getBirdId()
    }
}
