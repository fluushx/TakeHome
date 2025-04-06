//
//  BirdDetailPresenter.swift
//  TakeHome
//
//  Created by Felipe I Zapata R on 03-04-25.

import UIKit

// MARK: - BirdDetailPresenter
final class BirdDetailPresenter: BirdDetailPresenterProtocol {
    var interactor: BirdDetailPresenterInteractorProtocol
    var router: BirdDetailRouterProtocol?
    weak var view: BirdDetailViewProtocol?

    // MARK: - Inits
    init(interactor: BirdDetailPresenterInteractorProtocol, router: BirdDetailRouterProtocol?) {
        self.interactor = interactor
        self.router = router
    }
}

// MARK: - BirdDetailViewPresenterProtocol
extension BirdDetailPresenter: BirdDetailViewPresenterProtocol {
    func goToAddNote() {
        let notes = interactor.getNotes()
        let birdId = interactor.getBirdId()
        router?.goToAddNote(
            birdId: birdId,
            notes: notes
        )
        
    }
    func getNotes() -> [Notes] {
        interactor.getNotes()
    }
    func dismissModule() {
        router?.dismissModule(completion: nil)
    }
}
