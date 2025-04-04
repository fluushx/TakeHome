//
//  AddNoteBirdViewController.swift
//  TakeHome
//
//  Created by Felipe I Zapata R on 04-04-25.
//  Copyright (c) 2025 Falabella FIF. All rights reserved.

import UIKit

// MARK: - AddNoteBirdViewController
final class AddNoteBirdViewController: UIViewController {
	var presenter: AddNoteBirdViewPresenterProtocol?
}

// MARK: View Life Cycle
extension AddNoteBirdViewController {
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .green
    }
}

// MARK: AddNoteBirdViewProtocol
extension AddNoteBirdViewController: AddNoteBirdViewProtocol {
}
