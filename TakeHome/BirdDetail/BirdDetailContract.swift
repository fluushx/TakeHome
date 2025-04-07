//
//  BirdDetailContract.swift
//  TakeHome
//
//  Created by Felipe I Zapata R on 03-04-25.

import UIKit

// MARK: - Factory
protocol BirdDetailFactoryProtocol {
    static func initialize(selectedBird: BirdDisplayModel) -> BirdDetailViewController
}

// MARK: - Router
protocol BirdDetailRouterProtocol: AnyObject {
    var view: UIViewController? { get set }
    func goToAddNote(addNoteDataModel: AddNoteBirdDisplayModel)
    func dismissModule(completion: (() -> Void)?)
}

// MARK: - View
protocol BirdDetailViewProtocol: AnyObject {
    var presenter: BirdDetailViewPresenterProtocol? { get set }
    func updateNotes(_ notes: [Notes])
    func showLoading()
    func hideLoading()
    func showError()

}

// MARK: - View -> Presenter
protocol BirdDetailViewPresenterProtocol: AnyObject {
    func goToAddNote()
    func getNotes() -> [Notes]
    func dismissModule()
    func getBirdImage() -> UIImage
    func getTitleNav() -> String
    func callUpdateNotes()
}

// MARK: - Presenter
protocol BirdDetailPresenterProtocol: AnyObject {
    var interactor: BirdDetailPresenterInteractorProtocol { get set }
    var router: BirdDetailRouterProtocol? { get set }
    var view: BirdDetailViewProtocol? { get set }
}

// MARK: - Presenter -> Interactor
protocol BirdDetailPresenterInteractorProtocol: AnyObject {
    func getBirdDetailData() -> BirDetailDisplayModel
    func fetchBirdNotes(id: String, completion: @escaping (Result<[Notes], Error>) -> Void)
}

// MARK: - Interactor
protocol BirdDetailInteractorProtocol: BirdDetailRepositoryProtocol {}

// MARK: - Repository
protocol BirdDetailRepositoryProtocol {
    var localDataSource: BirdDetailLocalDataSourceProtocol { get set }
    var cloudDataSource: BirdDetailCloudDataSourceProtocol { get set }
}

// MARK: - Local Data Source
protocol BirdDetailLocalDataSourceProtocol {
    func getBirdDetailData() -> BirDetailDisplayModel
    func updateBirdNotes(birdNotes: [Notes]) -> BirdDisplayModel
}

// MARK: - Cloud Data Source
protocol BirdDetailCloudDataSourceProtocol {
    func fetchBirdNotes(id: String, completion: @escaping (Result<[Notes], Error>) -> Void)
}

