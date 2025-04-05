//
//  BirdDetailFactory.swift
//  TakeHome
//
//  Created by Felipe I Zapata R on 03-04-25.

// MARK: - BirdDetailFactory
public class BirdDetailFactory: BirdDetailFactoryProtocol {
    static func initialize(selectedBird: BirdModel) -> BirdDetailViewController {
        let interactor = BirdDetailInteractor(localDataSource: BirdDetailLocalDataSource(selectedBird: selectedBird),
                                                              cloudDataSource: BirdDetailCloudDataSource())

        let router = BirdDetailRouter()
        let presenter = BirdDetailPresenter(interactor: interactor, router: router)

        let viewController = BirdDetailViewController()

        presenter.view = viewController
        viewController.presenter = presenter
        router.view = viewController

        return viewController
    }
}
