//
//  ViewController.swift
//  ScipyMobile
//
//  Created by Alex Do on 3/19/22.
//

import UIKit

class CalculusController: ContentViewController {
    lazy var functionInput: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter function here"
        textField.borderStyle = UITextField.BorderStyle.line
        textField.backgroundColor = .lightGray
        textField.textAlignment = .center
        textField.delegate = self
        textField.returnKeyType = .done
        textField.autocapitalizationType = .none
        return textField
    }()
    
    lazy var derivativeResult: UILabel = {
        let textLabel = UILabel()
        textLabel.backgroundColor = .lightGray
        textLabel.textAlignment = .center
        textLabel.layer.borderColor = UIColor.black.cgColor
        textLabel.layer.borderWidth = 0.5
        return textLabel
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "Calculus"
        view.addSubview(functionInput)
        view.addSubview(derivativeResult)
        
        functionInput.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: nil, bottom: derivativeResult.topAnchor, right: nil, padding: .init(top: 50, left: 0, bottom: 0, right: 0), size: .init(width: 300, height: 30))
        functionInput.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        derivativeResult.anchor(top: functionInput.bottomAnchor, left: nil, bottom: nil, right: nil, padding: .init(top: 10, left: 0, bottom: 0, right: 0), size: .init(width: 300, height: 30))
        derivativeResult.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    func fetchSymbolicDerivative(for expression: String) {
        ScipyService.sharedInstance.fetchSymbolicDerivative(for: expression) { (derivative) in
            self.derivativeResult.text = derivative
        }
    }
}

extension CalculusController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        derivativeResult.text = ""
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let expression = textField.text {
            fetchSymbolicDerivative(for: expression)
        }
        functionInput.resignFirstResponder()
        return true
    }
}

