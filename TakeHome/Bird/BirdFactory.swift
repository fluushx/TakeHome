//
//  BirdFactory.swift
//  TakeHome
//
//  Created by Felipe I Zapata R on 03-04-25.

// MARK: - BirdFactory
public final class BirdFactory: BirdFactoryProtocol {
    static func initialize() -> BirdViewController {
        let interactor = BirdInteractor(localDataSource: BirdLocalDataSource(),
                                                              cloudDataSource: BirdCloudDataSource())

        let router = BirdRouter()
        let presenter = BirdPresenter(interactor: interactor, router: router)
        let viewController = BirdViewController()

        presenter.view = viewController
        viewController.presenter = presenter
        router.view = viewController

        return viewController
    }
}
