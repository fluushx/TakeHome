//
//  AddNoteBirdDisplayModel.swift
//  TakeHome
//
//  Created by Felipe I Zapata R on 06-04-25.
//

import Foundation
import UIKit

final class AddNoteBirdDisplayModel {
    let birdId: String?
    let birdImage: UIImage?
    let addNoteTitle: String?
    
    init(birdId: String?, birdImage: UIImage?, addNoteTitle: String?) {
        self.birdId = birdId
        self.birdImage = birdImage
        self.addNoteTitle = addNoteTitle
    }
}
