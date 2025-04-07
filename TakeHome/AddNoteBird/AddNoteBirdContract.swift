//
//  AddNoteBirdContract.swift
//  TakeHome
//
//  Created by Felipe I Zapata R on 04-04-25.

import UIKit

// MARK: - Factory
protocol AddNoteBirdFactoryProtocol {
    static func initialize(addNoteDataModel: AddNoteBirdDisplayModel)-> AddNoteBirdViewController
}

// MARK: - Router
protocol AddNoteBirdRouterProtocol: AnyObject {
    var view: UIViewController? { get set }
    func dismissModule()
}

// MARK: - View
protocol AddNoteBirdViewProtocol: AnyObject {
    var presenter: AddNoteBirdViewPresenterProtocol? { get set }
    func showLoading()
    func hideLoading()
    func showError()
}

// MARK: - View -> Presenter
protocol AddNoteBirdViewPresenterProtocol: AnyObject {
    func dismissModule()
    func callAddNote(comment: String) async
    func getBirdImage() -> UIImage
    func addNoteTitle() -> String
}

// MARK: - Presenter
protocol AddNoteBirdPresenterProtocol: AnyObject {
    var interactor: AddNoteBirdPresenterInteractorProtocol { get set }
    var router: AddNoteBirdRouterProtocol? { get set }
    var view: AddNoteBirdViewProtocol? { get set }
}

// MARK: - Presenter -> Interactor
protocol AddNoteBirdPresenterInteractorProtocol: AnyObject {
    func callAddNoteBirdAsync(birdId: String, comment: String) async throws -> Bool
    func getBirdId() -> String
    func getBirdImage() -> UIImage
    func addNoteTitle() -> String
}

// MARK: - Interactor
protocol AddNoteBirdInteractorProtocol: AddNoteBirdRepositoryProtocol {}

// MARK: - Repository
protocol AddNoteBirdRepositoryProtocol {
    var localDataSource: AddNoteBirdLocalDataSourceProtocol { get set }
    var cloudDataSource: AddNoteBirdCloudDataSourceProtocol { get set }
}

// MARK: - Local Data Source
protocol AddNoteBirdLocalDataSourceProtocol {
    func getBirdId() -> String
    func getBirdImage() -> UIImage
    func addNoteTitle() -> String
}

// MARK: - Cloud Data Source
protocol AddNoteBirdCloudDataSourceProtocol {
    func callAddNoteBirdAsync(birdId: String, comment: String, timestamp: Int) async throws -> Bool
}

