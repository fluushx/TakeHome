//
//  BirdModel.swift
//  TakeHome
//
//  Created by Felipe I Zapata R on 03-04-25.
//

import Foundation

// MARK: - Respuesta Principal
struct BirdResponse: Codable {
    let data: BirdsData?
}

// MARK: - Data de Aves
struct BirdsData: Codable {
    let birds: [BirdModel]?
}

// MARK: - Modelo para cada Ave
struct BirdModel: Codable {
    let id: String?
    let thumbURL: URL?
    let imageURL: URL?
    let latinName: String?
    let englishName: String?
    let notes: [Note]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case thumbURL = "thumb_url"
        case imageURL = "image_url"
        case latinName = "latin_name"
        case englishName = "english_name"
        case notes
    }
}

// MARK: - Modelo para Notas
struct Note: Codable {
    let id: String?
    let comment: String?
    let timestamp: Int?
}
