//
//  BirdDetailLocalDataSource.swift
//  TakeHome
//
//  Created by Felipe I Zapata R on 03-04-25.
//  Copyright (c) 2025 Falabella FIF. All rights reserved.

// MARK: - BirdDetailLocalDataSource
final class BirdDetailLocalDataSource: BirdDetailLocalDataSourceProtocol {
    var notes = [Note]()
    var selectedBird: BirdModel?
    
    init(selectedBird: BirdModel?) {
        self.selectedBird = selectedBird
    }
    
    func getNotes() -> [Note] {
        return selectedBird?.notes ?? []
    }
    func getBirdId() -> String {
        return selectedBird?.id ?? ""
    }
}
