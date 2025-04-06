//
//  AddNoteBirdLocalDataSource.swift
//  TakeHome
//
//  Created by Felipe I Zapata R on 04-04-25.

import UIKit

// MARK: - AddNoteBirdLocalDataSource
final class AddNoteBirdLocalDataSource: AddNoteBirdLocalDataSourceProtocol {
    
    var addNoteDataModel: AddNoteBirdDisplayModel?
    init(addNoteDataModel: AddNoteBirdDisplayModel) {
        self.addNoteDataModel = addNoteDataModel
    }
    func getBirdId() -> String {
        return addNoteDataModel?.birdId ?? ""
    }
    func getBirdImage() -> UIImage {
        return addNoteDataModel?.birdImage ?? UIImage()
    }
    func addNoteTitle() -> String {
        return addNoteDataModel?.addNoteTitle ?? ""
    }
}
