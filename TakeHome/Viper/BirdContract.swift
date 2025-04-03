//
//  BirdContract.swift
//  TakeHome
//
//  Created by Felipe I Zapata R on 03-04-25.
//  Copyright (c) 2025 Falabella FIF. All rights reserved.

import UIKit

// MARK: - Factory
protocol BirdFactoryProtocol {
    static func initialize() -> BirdViewController
}

// MARK: - Router
protocol BirdRouterProtocol: AnyObject {
    var view: UIViewController? { get set }
}

// MARK: - View
protocol BirdViewProtocol: AnyObject {
    var presenter: BirdViewPresenterProtocol? { get set }
}

// MARK: - View -> Presenter
protocol BirdViewPresenterProtocol: AnyObject {
}

// MARK: - Presenter
protocol BirdPresenterProtocol: AnyObject {
    var interactor: BirdPresenterInteractorProtocol { get set }
    var router: BirdRouterProtocol? { get set }
    var view: BirdViewProtocol? { get set }
}

// MARK: - Presenter -> Interactor
protocol BirdPresenterInteractorProtocol: AnyObject {
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
}

// MARK: - Cloud Data Source
protocol BirdCloudDataSourceProtocol {
}

