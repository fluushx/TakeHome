//
//  BirdLocalDataSource.swift
//  TakeHome
//
//  Created by Felipe I Zapata R on 03-04-25.

// MARK: - BirdLocalDataSource
final class BirdLocalDataSource: BirdLocalDataSourceProtocol {
    var birdModel = [BirdDisplayModel]()
    
    func setBirdData(_ birdData: [BirdDisplayModel]) {
        self.birdModel = birdData
    }
    func getBirdData() -> [BirdDisplayModel] {
        return birdModel
    }
}
