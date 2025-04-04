//
//  BirdDetailContract.swift
//  TakeHome
//
//  Created by Felipe I Zapata R on 03-04-25.
//  Copyright (c) 2025 Falabella FIF. All rights reserved.

import UIKit

// MARK: - Factory
protocol BirdDetailFactoryProtocol {
    static func initialize(selectedBird: BirdModel) -> BirdDetailViewController
}

// MARK: - Router
protocol BirdDetailRouterProtocol: AnyObject {
    var view: UIViewController? { get set }
    func goToAddNote()
}

// MARK: - View
protocol BirdDetailViewProtocol: AnyObject {
    var presenter: BirdDetailViewPresenterProtocol? { get set }
}

// MARK: - View -> Presenter
protocol BirdDetailViewPresenterProtocol: AnyObject {
    func goToAddNote()
}

// MARK: - Presenter
protocol BirdDetailPresenterProtocol: AnyObject {
    var interactor: BirdDetailPresenterInteractorProtocol { get set }
    var router: BirdDetailRouterProtocol? { get set }
    var view: BirdDetailViewProtocol? { get set }
}

// MARK: - Presenter -> Interactor
protocol BirdDetailPresenterInteractorProtocol: AnyObject {
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
}

// MARK: - Cloud Data Source
protocol BirdDetailCloudDataSourceProtocol {
}

