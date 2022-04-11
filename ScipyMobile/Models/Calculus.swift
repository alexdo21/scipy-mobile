//
//  Calculus.swift
//  ScipyMobile
//
//  Created by Alex Do on 3/19/22.
//

struct SymbolicDerivative: Codable {
    let symbolicDerivative: String
    enum CodingKeys: String, CodingKey {
        case symbolicDerivative = "symbolicDerivative"
    }
}

struct SymbolicIntegral: Codable {
    let symbolicIntegral: String
    enum CodingKeys: String, CodingKey {
        case symbolicIntegral = "symbolicIntegral"
    }
}
