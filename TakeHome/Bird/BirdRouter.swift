//
//  BirdRouter.swift
//  TakeHome
//
//  Created by Felipe I Zapata R on 03-04-25.

import UIKit

// MARK: - BirdRouter
final class BirdRouter: BirdRouterProtocol {
    weak var view: UIViewController?
    func presentBirdDetail(_ birdData: BirdDisplayModel) {
        let birdDetailVC = BirdDetailFactory.initialize(selectedBird: birdData)
        self.view?.navigationController?.present(birdDetailVC, animated: true)
    }
}
