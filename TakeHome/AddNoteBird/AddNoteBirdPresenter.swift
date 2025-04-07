//
//  AddNoteBirdPresenter.swift
//  TakeHome
//
//  Created by Felipe I Zapata R on 04-04-25.

import UIKit

// MARK: - AddNoteBirdPresenter
final class AddNoteBirdPresenter: AddNoteBirdPresenterProtocol {
    var interactor: AddNoteBirdPresenterInteractorProtocol
    var router: AddNoteBirdRouterProtocol?
    weak var view: AddNoteBirdViewProtocol?

    // MARK: - Inits
    init(interactor: AddNoteBirdPresenterInteractorProtocol, router: AddNoteBirdRouterProtocol?) {
        self.interactor = interactor
        self.router = router
    }
}

// MARK: - AddNoteBirdViewPresenterProtocol
extension AddNoteBirdPresenter: AddNoteBirdViewPresenterProtocol {
    func addNoteTitle() -> String {
        interactor.addNoteTitle()
    }
    
    func dismissModule() {
        router?.dismissModule()
    }
    func getBirdImage() -> UIImage {
        interactor.getBirdImage()
    }
    
    func callAddNote(comment: String) async {
        view?.showLoading()
        do {
            let birdId = interactor.getBirdId()
            _ = try await interactor.callAddNoteBirdAsync(
                birdId: birdId,
                comment: comment
            )
            view?.hideLoading()
        } catch {
            view?.showError()
        }
    }
}
