//
//  BirdConstant.swift
//  TakeHome
//
//  Created by Felipe I Zapata R on 03-04-25.
//  Copyright (c) 2025 Falabella FIF. All rights reserved.
//

import Foundation


// MARK: - BirdConstant
enum BirdConstant: BirdConstantProtocol {}

// MARK: - BirdConstantProtocol
protocol BirdConstantProtocol {
    // MARK: Texts & msg:
    static var navBarTitle: String { get }
}

// MARK: - BirdConstantProtocol Default
extension BirdConstantProtocol {
    // MARK: Texts & msg:
    static var navBarTitle: String { return "Your feature" }
}



