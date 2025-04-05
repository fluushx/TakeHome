//
//  BirdContract.swift
//  TakeHome
//
//  Created by Felipe I Zapata R on 03-04-25.

import UIKit

// MARK: - Factory
protocol BirdFactoryProtocol {
    static func initialize() -> BirdViewController
}

// MARK: - Router
protocol BirdRouterProtocol: AnyObject {
    var view: UIViewController? { get set }
    func presentBirdDetail(_ birdData: BirdModel)
}

// MARK: - View
protocol BirdViewProtocol: AnyObject {
    var presenter: BirdViewPresenterProtocol? { get set }
    func showLoading()
    func hideLoading()
    func showError()
}

// MARK: - View -> Presenter
protocol BirdViewPresenterProtocol: AnyObject {
    func fetchBirdDataAsync() async
    func getBirdData() -> [BirdModel]
    func didSelectBird(_ birdData: BirdModel)
}

// MARK: - Presenter
protocol BirdPresenterProtocol: AnyObject {
    var interactor: BirdPresenterInteractorProtocol { get set }
    var router: BirdRouterProtocol? { get set }
    var view: BirdViewProtocol? { get set }
}

// MARK: - Presenter -> Interactor
protocol BirdPresenterInteractorProtocol: AnyObject {
    func fetchBirdDataAsync() async throws -> [BirdModel]
    func getBirdData() -> [BirdModel]
}

// MARK: - Interactor
protocol BirdInteractorProtocol: BirdRepositoryProtocol {}

// MARK: - Repository
protocol BirdRepositoryProtocol {
    var localDataSource: BirdLocalDataSourceProtocol { get set }
    var cloudDataSource: BirdCloudDataSourceProtocol { get set }
}

// MARK: - Local Data Source
protocol BirdLocalDataSourceProtocol {
    func setBirdData(_ birdData: [BirdModel])
    func getBirdData() -> [BirdModel]
    
}

// MARK: - Cloud Data Source
protocol BirdCloudDataSourceProtocol {
    func fetchBirdDataAsync() async throws -> [BirdModel]
}

