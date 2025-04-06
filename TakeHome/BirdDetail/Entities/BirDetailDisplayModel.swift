//
//  BirDetailDisplayModel.swift
//  TakeHome
//
//  Created by Felipe I Zapata R on 06-04-25.
//

import Foundation
import UIKit

final class BirDetailDisplayModel {
    var notes: [Notes]?
    var birdId: String?
    var birdImage: UIImage?
    var title: String?
    
    init(notes: [Notes]? = nil, birdId: String? = nil, birdImage: UIImage? = nil, title: String? = nil) {
        self.notes = notes
        self.birdId = birdId
        self.birdImage = birdImage
        self.title = title
    }
}
