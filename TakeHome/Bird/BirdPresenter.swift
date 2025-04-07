//
//  BirdPresenter.swift
//  TakeHome
//
//  Created by Felipe I Zapata R on 03-04-25.

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
 
}

// MARK: - BirdViewPresenterProtocol
extension BirdPresenter: BirdViewPresenterProtocol {
    func fetchBirdData() {
        view?.showLoading()
        interactor.fetchBirdDataWithImages(onBatch: { [weak self] updatedBirds in
            DispatchQueue.main.async {
                self?.view?.updateBirdsDisplay(with: updatedBirds)
                self?.view?.hideLoading()
            }
        }, completion: { [weak self] finalBirds in
            DispatchQueue.main.async {
                if finalBirds.isEmpty {
                    self?.view?.showError()
                } else {
                    self?.view?.updateBirdsDisplay(with: finalBirds)
                }
            }
        })
    }
    
    func getBirdData() -> [BirdDisplayModel] {
        interactor.getBirdData()
    }
    func didSelectBird(_ birdData: BirdDisplayModel) {
        router?.presentBirdDetail(birdData)
        
    }
}
