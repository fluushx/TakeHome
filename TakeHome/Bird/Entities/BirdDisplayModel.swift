//
//  BirdDisplayModel.swift
//  TakeHome
//
//  Created by Felipe I Zapata R on 06-04-25.
//

import Foundation
import UIKit

final class BirdDisplayModel {
    let id: String?
    let thumbURL: URL?
    let imageURL: URL?
    let latinName: String?
    let englishName: String?
    let notes: [Notes]?
    var image: UIImage?
    init(id: String?, thumbURL: URL?, imageURL: URL?, latinName: String?, englishName: String?, notes: [Notes]?, image: UIImage?) {
        self.id = id
        self.thumbURL = thumbURL
        self.imageURL = imageURL
        self.latinName = latinName
        self.englishName = englishName
        self.notes = notes
        self.image = image
    }
}
final class Notes {
    let id: String?
    let comment: String?
    let timestamp: Int?
    init(id: String?, comment: String?, timestamp: Int?) {
        self.id = id
        self.comment = comment
        self.timestamp = timestamp
    }
}
