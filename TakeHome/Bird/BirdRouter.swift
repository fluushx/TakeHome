//
//  BirdRouter.swift
//  TakeHome
//
//  Created by Felipe I Zapata R on 03-04-25.
//  Copyright (c) 2025 Falabella FIF. All rights reserved.

import UIKit

// MARK: - BirdRouter
final class BirdRouter: BirdRouterProtocol {
    weak var view: UIViewController?
    func presentBirdDetail(_ birdData: BirdModel) {
        let birdDetailVC = BirdDetailFactory.initialize(selectedBird: birdData)
        self.view?.navigationController?.present(birdDetailVC, animated: true)
    }
}
