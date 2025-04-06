//
//  AddNoteBirdFactory.swift
//  TakeHome
//
//  Created by Felipe I Zapata R on 04-04-25.

// MARK: - AddNoteBirdFactory
public class AddNoteBirdFactory: AddNoteBirdFactoryProtocol {
    static func initialize(addNoteDataModel: AddNoteBirdDisplayModel) -> AddNoteBirdViewController {
        let interactor = AddNoteBirdInteractor(
            localDataSource: AddNoteBirdLocalDataSource(
                addNoteDataModel: addNoteDataModel
            ),
            cloudDataSource: AddNoteBirdCloudDataSource()
        )

        let router = AddNoteBirdRouter()

        let presenter = AddNoteBirdPresenter(interactor: interactor, router: router)

        let viewController = AddNoteBirdViewController()

        presenter.view = viewController
        viewController.presenter = presenter
        router.view = viewController

        return viewController
    }
}
