//
//  LinearAlgebra.swift
//  ScipyMobile
//
//  Created by Alex Do on 3/19/22.
//

struct Inverse: Codable {
    let inverseMatrix: [[Float]]
    enum CodingKeys: String, CodingKey {
        case inverseMatrix = "inverseMatrix"
    }
}

struct Determinant: Codable {
    let determinant: Float
    enum CodingKeys: String, CodingKey {
        case determinant = "determinant"
    }
}
