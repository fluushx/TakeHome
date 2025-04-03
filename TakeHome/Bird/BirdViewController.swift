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
        fetchBirdData()
        
    }
    func fetchBirdData() {
        Task { [weak self] in
            await self?.presenter?.fetchBirdDataAsync()
            let data = self?.presenter?.getBirdData() ?? []
            print("Datos obtenidos: \(data)")
        }
    }
}

// MARK: BirdViewProtocol
extension BirdViewController: BirdViewProtocol {
    func showError() {
        print("showError")
    }
    func showLoading() {
        print("showLoading")
    }
    func hideLoading() {
        print("hideLoading")
    }
}
