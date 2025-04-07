//
//  AddNoteBirdInteractor.swift
//  TakeHome
//
//  Created by Felipe I Zapata R on 04-04-25.

import Foundation
import UIKit

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
        let timeStamp = randomInt(from: 0, to: 100)
        let addNoteSuccess = try await cloudDataSource.callAddNoteBirdAsync(
            birdId: birdId,
            comment: comment,
            timestamp: timeStamp
        )
        return addNoteSuccess
    }
    func getBirdId() -> String {
        localDataSource.getBirdId()
    }
    func getBirdImage() -> UIImage {
        localDataSource.getBirdImage()
    }
    func addNoteTitle() -> String {
        localDataSource.addNoteTitle()
    }
}

extension AddNoteBirdInteractor {
    func randomInt(from min: Int, to max: Int) -> Int {
        return Int.random(in: min...max)
    }
}
