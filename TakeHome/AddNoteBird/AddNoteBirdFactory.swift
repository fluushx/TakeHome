//
//  AddNoteBirdFactory.swift
//  TakeHome
//
//  Created by Felipe I Zapata R on 04-04-25.

// MARK: - AddNoteBirdFactory
public class AddNoteBirdFactory: AddNoteBirdFactoryProtocol {
    static func initialize(birdId: String, notes: [Notes]) -> AddNoteBirdViewController {
        let interactor = AddNoteBirdInteractor(localDataSource: AddNoteBirdLocalDataSource(birdId: birdId),
                                                              cloudDataSource: AddNoteBirdCloudDataSource())

        let router = AddNoteBirdRouter()

        let presenter = AddNoteBirdPresenter(interactor: interactor, router: router)

        let viewController = AddNoteBirdViewController()

        presenter.view = viewController
        viewController.presenter = presenter
        router.view = viewController

        return viewController
    }
}
