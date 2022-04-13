//
//  SettingsViewController.swift
//  ScipyMobile
//
//  Created by Alex Do on 4/5/22.
//

import UIKit
import MathEditor

class LinearAlgebraController: ContentViewController {
    let container: UIStackView = UIStackView()
    let openBracket: UIView = {
        let bracket = UIView()
        bracket.addBorders(to: [.top, .left, .bottom], in: .black, width: 2)
        return bracket
    }()
    let closeBracket: UIView = {
        let bracket = UIView()
        bracket.addBorders(to: [.top, .right, .bottom], in: .black, width: 2)
        return bracket
    }()
    let matrixEditor: UIStackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Linear Algebra | Determinant of Matrix"
        
        view.addSubview(container)

        container.addArrangedSubview(openBracket)
        container.addArrangedSubview(matrixEditor)
        container.addArrangedSubview(closeBracket)
        
        container.distribution = .fillProportionally
        container.spacing = 5
        
        openBracket.widthAnchor.constraint(equalToConstant: 10).isActive = true
        closeBracket.widthAnchor.constraint(equalToConstant: 10).isActive = true

        matrixEditor.axis = .vertical
        matrixEditor.distribution = .fillEqually
        matrixEditor.spacing = 15
        for _ in 1...3 {
            let row = UIStackView()
            row.distribution = .fillEqually
            row.spacing = 15
            for _ in 1...3 {
                let entry = UITextField()
                entry.delegate = self
                entry.textAlignment = .center
                entry.text = "?"
                entry.textColor = .white
                entry.font = UIFont.systemFont(ofSize: 36)
                entry.backgroundColor = UIColor.rgb(red: 173, green: 187, blue: 187)
                row.addArrangedSubview(entry)
            }
            matrixEditor.addArrangedSubview(row)
        }
//        let row: UIStackView = matrixEditor.arrangedSubviews[1] as! UIStackView
//        let entry: UITextField = row.arrangedSubviews[1] as! UITextField
//        entry.text = "5"
        container.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, padding: .init(top: 69, left: 20, bottom: 20, right: 20), size: .init(width: 203, height: 174))
    }
}

extension LinearAlgebraController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
//    func textFieldDidBeginEditing(_ textField: UITextField) -> Bool {
//        textField.text = ""
//        return true
//    }
}
