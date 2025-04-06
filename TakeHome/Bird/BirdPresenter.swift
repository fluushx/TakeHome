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
                // Cada vez que se procesa un lote se actualiza la vista
                DispatchQueue.main.async {
                    self?.view?.updateBirdsDisplay(with: updatedBirds)
                    self?.view?.hideLoading()
                }
            }, completion: { [weak self] finalBirds in
                // Cuando se completó la descarga de todos los lotes, se actualiza la vista y se oculta el loading
                DispatchQueue.main.async {
                    self?.view?.updateBirdsDisplay(with: finalBirds)
                   
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
