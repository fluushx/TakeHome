//
//  BirdViewController.swift
//  TakeHome
//
//  Created by Felipe I Zapata R on 03-04-25.
//  Copyright (c) 2025 Falabella FIF. All rights reserved.

import UIKit

// MARK: - BirdViewController
final class BirdViewController: UIViewController {
	var presenter: BirdViewPresenterProtocol?
}

// MARK: View Life Cycle
extension BirdViewController {
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .red
    }
}

// MARK: BirdViewProtocol
extension BirdViewController: BirdViewProtocol {
}
