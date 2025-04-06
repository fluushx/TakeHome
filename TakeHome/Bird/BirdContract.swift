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
    func presentBirdDetail(_ birdData: BirdDisplayModel)
}

// MARK: - View
protocol BirdViewProtocol: AnyObject {
    var presenter: BirdViewPresenterProtocol? { get set }
    func showLoading()
    func hideLoading()
    func showError()
    func updateBirdsDisplay(with birds: [BirdDisplayModel])
}

// MARK: - View -> Presenter
protocol BirdViewPresenterProtocol: AnyObject {
    func fetchBirdData()
    func getBirdData() -> [BirdDisplayModel]
    func didSelectBird(_ birdData: BirdDisplayModel)
}

// MARK: - Presenter
protocol BirdPresenterProtocol: AnyObject {
    var interactor: BirdPresenterInteractorProtocol { get set }
    var router: BirdRouterProtocol? { get set }
    var view: BirdViewProtocol? { get set }
}

// MARK: - Presenter -> Interactor
protocol BirdPresenterInteractorProtocol: AnyObject {
    func fetchBirdDataWithImages(onBatch: @escaping ([BirdDisplayModel]) -> Void,
                                 completion: @escaping ([BirdDisplayModel]) -> Void)
    func getBirdData() -> [BirdDisplayModel]
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
    func setBirdData(_ birdData: [BirdDisplayModel])
    func getBirdData() -> [BirdDisplayModel]
    
}

// MARK: - Cloud Data Source
protocol BirdCloudDataSourceProtocol {
    func fetchBirdData(completion: @escaping (Result<[BirdDisplayModel], Error>) -> Void)
    func downloadImage(for url: URL, completion: @escaping (UIImage?) -> Void)
}

