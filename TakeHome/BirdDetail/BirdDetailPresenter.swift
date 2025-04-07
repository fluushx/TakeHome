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
    func getBirdDetailData() -> BirDetailDisplayModel {
        interactor.getBirdDetailData()
    }
    
    func goToAddNote() {
        let birdImage = interactor.getBirdDetailData().birdImage
        let birdId = interactor.getBirdDetailData().birdId ?? ""
        let birdTitle = interactor.getBirdDetailData().title ?? ""
        let addNodeDataModel = AddNoteBirdDisplayModel(
            birdId: birdId,
            birdImage: birdImage,
            addNoteTitle: birdTitle
        )
        router?.goToAddNote(addNoteDataModel: addNodeDataModel)
        
    }
    func getNotes() -> [Notes] {
        interactor.getBirdDetailData().notes ?? []
    }
    func dismissModule() {
        router?.dismissModule(completion: nil)
    }
    func getBirdImage() -> UIImage {
        interactor.getBirdDetailData().birdImage ?? UIImage()
    }
    func getTitleNav() -> String {
        interactor.getBirdDetailData().title ?? ""
    }
    func callUpdateNotes() {
        view?.showLoading()
        let birdId = interactor.getBirdDetailData().birdId ?? ""
        interactor.fetchBirdNotes(id: birdId) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else {
                    return
                }
                self.view?.hideLoading()
                switch result {
                case .success(let notes):
                    self.view?.updateNotes(notes)
                case .failure:
                    self.view?.showError()
                }
            }
        }
    }
    
}
