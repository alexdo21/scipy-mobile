//
//  ScipyService.swift
//  ScipyMobile
//
//  Created by Alex Do on 3/19/22.
//

import Foundation

class ScipyService: NSObject {
    static let sharedInstance = ScipyService()
    
    let BASE_URL = "http://127.0.0.1:5000/"

    func fetchSymbolicDerivative(for expression: String, completion: @escaping (String) -> ()) {
        let url = URL(string: BASE_URL + "calculus/monomial/symbolic-derivative")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let json: [String:Any] = ["expression": expression, "wrt": "x"]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {
                print(error ?? "")
                return
            }
            guard let data = data, let response = try? JSONDecoder().decode(SymbolicDerivative.self, from: data) else { return }
            DispatchQueue.main.async {
                completion(response.symbolicDerivative)
            }
        }
        task.resume()
    }

    func fetchMatrixInverse(for matrix: [[Int]], completion: @escaping ([[Float]]) -> ()) {
        let url = URL(string: BASE_URL + "linalg/inverse")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let json: [String:Any] = ["matrix": matrix]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        request.httpBody = jsonData
        
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {
                print(error ?? "")
                return
            }
            guard let data = data, let response = try? JSONDecoder().decode(Inverse.self, from: data) else { return }
            DispatchQueue.main.async {
                completion(response.inverseMatrix)
            }
        }
        task.resume()
    }

    func fetchMatrixDeterminant(for matrix: [[Int]], completion: @escaping (Float) -> ()) {
        let url = URL(string: BASE_URL + "linalg/determinant")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let json: [String:Any] = ["matrix": matrix]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        request.httpBody = jsonData
        
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {
                print(error ?? "")
                return
            }
            guard let data = data, let response = try? JSONDecoder().decode(Determinant.self, from: data) else { return }
            DispatchQueue.main.async {
                completion(response.determinant)
            }
        }
        task.resume()
    }

}
