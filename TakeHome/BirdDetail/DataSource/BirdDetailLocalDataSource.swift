//
//  BirdDetailLocalDataSource.swift
//  TakeHome
//
//  Created by Felipe I Zapata R on 03-04-25.

// MARK: - BirdDetailLocalDataSource
final class BirdDetailLocalDataSource: BirdDetailLocalDataSourceProtocol {
    var notes = [Notes]()
    var selectedBird: BirdDisplayModel?
    
    init(selectedBird: BirdDisplayModel?) {
        self.selectedBird = selectedBird
    }
    
    func getNotes() -> [Notes] {
        return selectedBird?.notes ?? []
    }
    func getBirdId() -> String {
        return selectedBird?.id ?? ""
    }
}
