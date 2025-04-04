//
//  AddNoteBirdModel.swift
//  TakeHome
//
//  Created by Felipe I Zapata R on 04-04-25.
//

import Foundation

struct AddNoteDataResponse: Codable {
    let data: AddNoteData
}

struct AddNoteData: Codable {
    let addNote: String
}
