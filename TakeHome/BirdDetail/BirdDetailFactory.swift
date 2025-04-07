//
//  BirdDetailFactory.swift
//  TakeHome
//
//  Created by Felipe I Zapata R on 03-04-25.

import Foundation

// MARK: - BirdDetailFactory
public class BirdDetailFactory: BirdDetailFactoryProtocol {
    static func initialize(selectedBird: BirdDisplayModel) -> BirdDetailViewController {
        let client = createClient(
            accessToken: "cXdP3HwiAio1trBSPdWA",
            url: URL(string: "https://takehome.graphql.copilot.money")!
        )
        let interactor = BirdDetailInteractor(localDataSource: BirdDetailLocalDataSource(selectedBird: selectedBird),
                                              cloudDataSource: BirdDetailCloudDataSource(client: client))

        let router = BirdDetailRouter()
        let presenter = BirdDetailPresenter(interactor: interactor, router: router)

        let viewController = BirdDetailViewController()

        presenter.view = viewController
        viewController.presenter = presenter
        router.view = viewController

        return viewController
    }
}
