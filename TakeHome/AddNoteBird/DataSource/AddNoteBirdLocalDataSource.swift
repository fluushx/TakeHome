//
//  AddNoteBirdLocalDataSource.swift
//  TakeHome
//
//  Created by Felipe I Zapata R on 04-04-25.

// MARK: - AddNoteBirdLocalDataSource
final class AddNoteBirdLocalDataSource: AddNoteBirdLocalDataSourceProtocol {
    var birdId: String = ""
    init(birdId: String) {
        self.birdId = birdId
    }
    func getBirdId() -> String {
        return birdId
    }
}
