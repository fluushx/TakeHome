//
//  BirdLocalDataSource.swift
//  TakeHome
//
//  Created by Felipe I Zapata R on 03-04-25.

// MARK: - BirdLocalDataSource
final class BirdLocalDataSource: BirdLocalDataSourceProtocol {
    var birdModel = [BirdModel]()
    
    func setBirdData(_ birdData: [BirdModel]) {
        self.birdModel = birdData
    }
    func getBirdData() -> [BirdModel] {
        return birdModel
    }
}
