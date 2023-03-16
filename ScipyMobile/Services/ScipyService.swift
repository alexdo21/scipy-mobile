//
//  ScipyService.swift
//  ScipyMobile
//
//  Created by Alex Do on 3/19/22.
//

import Foundation

class ScipyService: NSObject {
    static let sharedInstance = ScipyService()
    
    let BASE_URL = "http://192.168.0.129:8000/"

    func fetchSymbolicDerivative(for expression: String, _ wrt: String, completion: @escaping (String) -> ()) {
        let url = URL(string: BASE_URL + "calculus/symbolic-derivative")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let json: [String:Any] = ["expression": expression, "wrt": wrt]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {
                DispatchQueue.main.async {
                    completion("Error\\,unable\\,to\\,fetch")
                }
            }
            guard let data = data, let response = try? JSONDecoder().decode(SymbolicDerivative.self, from: data) else { return }
            DispatchQueue.main.async {
                completion(response.symbolicDerivative)
            }
        }
        task.resume()
    }
    
    func fetchSolveDerivative(for expression: String, _ wrt: String, _ atValue: String, completion: @escaping (String) -> ()) {
        let url = URL(string: BASE_URL + "calculus/solve-derivative")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let json: [String:Any] = ["expression": expression, "wrt": wrt, "atValue": atValue]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {
                DispatchQueue.main.async {
                    completion("Error\\,unable\\,to\\,fetch")
                }
            }
            guard let data = data, let response = try? JSONDecoder().decode(SolveDerivative.self, from: data) else { return }
            DispatchQueue.main.async {
                completion(response.derivativeResult)
            }
        }
        task.resume()
    }
    
    func fetchSymbolicIntegral(for expression: String, _ wrt: String, completion: @escaping (String) -> ()) {
        let url = URL(string: BASE_URL + "calculus/symbolic-integral")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let json: [String:Any] = ["expression": expression, "wrt": wrt]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {
                DispatchQueue.main.async {
                    completion("Error\\,unable\\,to\\,fetch")
                }
            }
            guard let data = data, let response = try? JSONDecoder().decode(SymbolicIntegral.self, from: data) else { return }
            DispatchQueue.main.async {
                completion(response.symbolicIntegral)
            }
        }
        task.resume()
    }

    func fetchSolveIntegral(for expression: String, _ wrt: String, _ from: String, _ to: String, completion: @escaping (String) -> ()) {
        let url = URL(string: BASE_URL + "calculus/solve-integral")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let json: [String:Any] = ["expression": expression, "wrt": wrt, "from": from, "to": to]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {
                DispatchQueue.main.async {
                    completion("Error\\,unable\\,to\\,fetch")
                }
            }
            guard let data = data, let response = try? JSONDecoder().decode(SolveIntegral.self, from: data) else { return }
            DispatchQueue.main.async {
                completion(response.integralResult)
            }
        }
        task.resume()
    }
    
    func fetchMatrixDeterminant(for matrix: [[Float]], completion: @escaping (Float?) -> ()) {
        let url = URL(string: BASE_URL + "linalg/determinant")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let json: [String:Any] = ["matrix": matrix]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
            guard let data = data, let response = try? JSONDecoder().decode(Determinant.self, from: data) else { return }
            DispatchQueue.main.async {
                completion(response.determinant)
            }
        }
        task.resume()
    }
    
    func fetchMatrixInverse(for matrix: [[Float]], completion: @escaping ([[Float]]?) -> ()) {
        let url = URL(string: BASE_URL + "linalg/inverse")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let json: [String:Any] = ["matrix": matrix]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
            guard let data = data, let response = try? JSONDecoder().decode(Inverse.self, from: data) else { return }
            DispatchQueue.main.async {
                completion(response.inverseMatrix)
            }
        }
        task.resume()
    }
}
