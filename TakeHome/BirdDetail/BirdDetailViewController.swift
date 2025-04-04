//
//  BirdDetailViewController.swift
//  TakeHome
//
//  Created by Felipe I Zapata R on 03-04-25.
//  Copyright (c) 2025 Falabella FIF. All rights reserved.

import UIKit

// MARK: - BirdDetailViewController
final class BirdDetailViewController: UIViewController {
	var presenter: BirdDetailViewPresenterProtocol?
}

// MARK: View Life Cycle
extension BirdDetailViewController {
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .yellow
    }
}

// MARK: BirdDetailViewProtocol
extension BirdDetailViewController: BirdDetailViewProtocol {
}
