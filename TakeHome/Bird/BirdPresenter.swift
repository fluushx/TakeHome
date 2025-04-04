//
//  BirdPresenter.swift
//  TakeHome
//
//  Created by Felipe I Zapata R on 03-04-25.
//  Copyright (c) 2025 Falabella FIF. All rights reserved.

import UIKit

// MARK: - BirdPresenter
final class BirdPresenter: BirdPresenterProtocol {
    var interactor: BirdPresenterInteractorProtocol
    var router: BirdRouterProtocol?
    weak var view: BirdViewProtocol?

    // MARK: - Inits
    init(interactor: BirdPresenterInteractorProtocol, router: BirdRouterProtocol?) {
        self.interactor = interactor
        self.router = router
    }
    func fetchBirdDataAsync() async {
        view?.showLoading()
        do {
           _ = try await interactor.fetchBirdDataAsync()
            view?.hideLoading()
        } catch {
            view?.hideLoading()
            view?.showError()
        }
    }
}

// MARK: - BirdViewPresenterProtocol
extension BirdPresenter: BirdViewPresenterProtocol {
    func getBirdData() -> [BirdModel] {
        interactor.getBirdData()
    }
    func didSelectBird(_ birdData: BirdModel) {
        router?.presentBirdDetail(birdData)
        
    }
}
