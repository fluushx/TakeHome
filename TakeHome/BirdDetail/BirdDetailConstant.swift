//
//  BirdDetailConstant.swift
//  TakeHome
//
//  Created by Felipe I Zapata R on 03-04-25.
//  Copyright (c) 2025 Falabella FIF. All rights reserved.
//

import Foundation


// MARK: - BirdDetailConstant
enum BirdDetailConstant: BirdDetailConstantProtocol {}

// MARK: - BirdDetailConstantProtocol
protocol BirdDetailConstantProtocol {
    // MARK: Texts & msg:
    static var navBarTitle: String { get }
}

// MARK: - BirdDetailConstantProtocol Default
extension BirdDetailConstantProtocol {
    // MARK: Texts & msg:
    static var navBarTitle: String { return "Your feature" }
}



