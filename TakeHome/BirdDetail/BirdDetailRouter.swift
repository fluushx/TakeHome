//
//  BirdDetailRouter.swift
//  TakeHome
//
//  Created by Felipe I Zapata R on 03-04-25.

import UIKit

// MARK: - BirdDetailRouter
final class BirdDetailRouter: BirdDetailRouterProtocol {
    weak var view: UIViewController?
    
    func goToAddNote(addNoteDataModel: AddNoteBirdDisplayModel){
        let birdDetailVC = AddNoteBirdFactory.initialize(addNoteDataModel: addNoteDataModel)
        self.view?.present(birdDetailVC, animated: true)
    }
    func dismissModule(completion: (() -> Void)?) {
        if let vc = view?.navigationController?.viewControllers.last(where: { $0.isKind(of: BirdViewController.self) }) {
            view?.navigationController?.popToViewController(vc, animated: true)
        } else {
            view?.dismiss(animated: true, completion: nil)
        }
    }
}
