//
//  BirdDetailLocalDataSource.swift
//  TakeHome
//
//  Created by Felipe I Zapata R on 03-04-25.

import UIKit

// MARK: - BirdDetailLocalDataSource
final class BirdDetailLocalDataSource: BirdDetailLocalDataSourceProtocol {
    var selectedBird: BirdDisplayModel?
    
    init(selectedBird: BirdDisplayModel?) {
        self.selectedBird = selectedBird
    }
    
    func getBirdDetailData() -> BirDetailDisplayModel {
        let birdNotes = selectedBird?.notes ?? []
        let birdId = selectedBird?.id ?? ""
        let birdImage = selectedBird?.image ?? UIImage()
        let birdTitle =  selectedBird?.englishName
        
        return BirDetailDisplayModel(
            notes: birdNotes,
            birdId: birdId,
            birdImage: birdImage,
            title: birdTitle
        )
    }
    func updateBirdNotes(birdNotes: [Notes]) -> BirdDisplayModel {
        selectedBird?.notes = birdNotes
        
        return selectedBird ?? BirdDisplayModel(
            id: "",
            thumbURL: nil,
            imageURL: nil,
            latinName: nil,
            englishName: nil,
            notes: nil,
            image: nil
        )
    }
}
