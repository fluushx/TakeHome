//
//  BirdDetailContract.swift
//  TakeHome
//
//  Created by Felipe I Zapata R on 03-04-25.

import UIKit

// MARK: - Factory
protocol BirdDetailFactoryProtocol {
    static func initialize(selectedBird: BirdModel) -> BirdDetailViewController
}

// MARK: - Router
protocol BirdDetailRouterProtocol: AnyObject {
    var view: UIViewController? { get set }
    func goToAddNote(birdId: String, notes: [Note])
    func dismissModule(completion: (() -> Void)?)
}

// MARK: - View
protocol BirdDetailViewProtocol: AnyObject {
    var presenter: BirdDetailViewPresenterProtocol? { get set }
}

// MARK: - View -> Presenter
protocol BirdDetailViewPresenterProtocol: AnyObject {
    func goToAddNote()
    func getNotes() -> [Note]
    func dismissModule()
}

// MARK: - Presenter
protocol BirdDetailPresenterProtocol: AnyObject {
    var interactor: BirdDetailPresenterInteractorProtocol { get set }
    var router: BirdDetailRouterProtocol? { get set }
    var view: BirdDetailViewProtocol? { get set }
}

// MARK: - Presenter -> Interactor
protocol BirdDetailPresenterInteractorProtocol: AnyObject {
    func getNotes() -> [Note]
    func getBirdId() -> String
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
    func getNotes() -> [Note]
    func getBirdId() -> String
}

// MARK: - Cloud Data Source
protocol BirdDetailCloudDataSourceProtocol {
}

