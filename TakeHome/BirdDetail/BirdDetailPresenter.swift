//
//  BirdDetailPresenter.swift
//  TakeHome
//
//  Created by Felipe I Zapata R on 03-04-25.
//  Copyright (c) 2025 Falabella FIF. All rights reserved.

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
        router?.goToAddNote()
    }
}
