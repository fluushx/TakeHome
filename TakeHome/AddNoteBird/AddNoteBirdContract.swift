//
//  AddNoteBirdContract.swift
//  TakeHome
//
//  Created by Felipe I Zapata R on 04-04-25.
//  Copyright (c) 2025 Falabella FIF. All rights reserved.

import UIKit

// MARK: - Factory
protocol AddNoteBirdFactoryProtocol {
    static func initialize(notes: [Note])-> AddNoteBirdViewController
}

// MARK: - Router
protocol AddNoteBirdRouterProtocol: AnyObject {
    var view: UIViewController? { get set }
    func dismissModule()
}

// MARK: - View
protocol AddNoteBirdViewProtocol: AnyObject {
    var presenter: AddNoteBirdViewPresenterProtocol? { get set }
}

// MARK: - View -> Presenter
protocol AddNoteBirdViewPresenterProtocol: AnyObject {
    func dismissModule()
}

// MARK: - Presenter
protocol AddNoteBirdPresenterProtocol: AnyObject {
    var interactor: AddNoteBirdPresenterInteractorProtocol { get set }
    var router: AddNoteBirdRouterProtocol? { get set }
    var view: AddNoteBirdViewProtocol? { get set }
}

// MARK: - Presenter -> Interactor
protocol AddNoteBirdPresenterInteractorProtocol: AnyObject {
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
}

// MARK: - Cloud Data Source
protocol AddNoteBirdCloudDataSourceProtocol {
}

