//
//  AddNoteBirdPresenter.swift
//  TakeHome
//
//  Created by Felipe I Zapata R on 04-04-25.
//  Copyright (c) 2025 Falabella FIF. All rights reserved.

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
    func dismissModule() {
        router?.dismissModule()
    }
    
    func callAddNote(comment: String) async {
        do {
            let birdId = interactor.getBirdId()
            _ = try await interactor.callAddNoteBirdAsync(
                birdId: birdId,
                comment: comment
            )
        } catch {
            print("error adding note")
        }
    }
}
