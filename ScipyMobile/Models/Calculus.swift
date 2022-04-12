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

struct SolveDerivative: Codable {
    let derivativeResult: String
    enum CodingKeys: String, CodingKey {
        case derivativeResult = "derivativeResult"
    }
}

struct SymbolicIntegral: Codable {
    let symbolicIntegral: String
    enum CodingKeys: String, CodingKey {
        case symbolicIntegral = "symbolicIntegral"
    }
}

struct SolveIntegral: Codable {
    let integralResult: String
    enum CodingKeys: String, CodingKey {
        case integralResult = "integralResult"
    }
}

