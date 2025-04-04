//
//  AddNoteBirdRouter.swift
//  TakeHome
//
//  Created by Felipe I Zapata R on 04-04-25.
//  Copyright (c) 2025 Falabella FIF. All rights reserved.

import UIKit

// MARK: - AddNoteBirdRouter
final class AddNoteBirdRouter: AddNoteBirdRouterProtocol {
    weak var view: UIViewController?
    
    func dismissModule() {
        if let navigationController = view?.navigationController {
            navigationController.dismiss(animated: true, completion: nil)
        } else {
            view?.dismiss(animated: true, completion: nil)
        }
    }
}
