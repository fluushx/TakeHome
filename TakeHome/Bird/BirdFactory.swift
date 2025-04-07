//
//  BirdFactory.swift
//  TakeHome
//
//  Created by Felipe I Zapata R on 03-04-25.

import Foundation

// MARK: - BirdFactory
public final class BirdFactory: BirdFactoryProtocol {
    static func initialize() -> BirdViewController {
        let client = createClient(
            accessToken: "cXdP3HwiAio1trBSPdWA",
            url: URL(string: "https://takehome.graphql.copilot.money")!
        )
        let interactor = BirdInteractor(localDataSource: BirdLocalDataSource(),
                                        cloudDataSource: BirdCloudDataSource(client: client))

        let router = BirdRouter()
        let presenter = BirdPresenter(interactor: interactor, router: router)
        let viewController = BirdViewController()

        presenter.view = viewController
        viewController.presenter = presenter
        router.view = viewController

        return viewController
    }
}
