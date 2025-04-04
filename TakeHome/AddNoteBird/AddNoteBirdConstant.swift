//
//  AddNoteBirdConstant.swift
//  TakeHome
//
//  Created by Felipe I Zapata R on 04-04-25.
//  Copyright (c) 2025 Falabella FIF. All rights reserved.
//

import Foundation


// MARK: - AddNoteBirdConstant
enum AddNoteBirdConstant: AddNoteBirdConstantProtocol {}

// MARK: - AddNoteBirdConstantProtocol
protocol AddNoteBirdConstantProtocol {
    // MARK: Texts & msg:
    static var navBarTitle: String { get }
}

// MARK: - AddNoteBirdConstantProtocol Default
extension AddNoteBirdConstantProtocol {
    // MARK: Texts & msg:
    static var navBarTitle: String { return "Your feature" }
}



