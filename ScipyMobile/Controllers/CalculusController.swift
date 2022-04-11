//
//  CalculusController.swift
//  ScipyMobile
//
//  Created by Alex Do on 4/7/22.
//

import UIKit
import MathEditor

class CalculusController: ContentViewController {
    let problemContainer = ProblemContainer()
    let editButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.attributedTitle = AttributedString("Edit", attributes: .init([
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18),
            NSAttributedString.Key.foregroundColor: UIColor.rgb(red: 173, green: 187, blue: 187)
        ]))
        config.titlePadding = 5
        let button = UIButton(configuration: config, primaryAction: nil)
        button.addTarget(self, action: #selector(handleEdit), for: .touchUpInside)
        return button
    }()
    let solveButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.titlePadding = 5
        let button = UIButton(configuration: config, primaryAction: nil)
        return button
    }()
    let controlPanelModal = ControlPanelModalViewController()
    let solutionModal = SolutionModalViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
                
        view.addSubview(problemContainer)
        let divider = VerticalDividerView()
        let buttons = UIStackView(arrangedSubviews: [editButton, divider, solveButton])
        buttons.distribution = .fillProportionally
        buttons.backgroundColor = .systemGray5
        view.addSubview(buttons)
        
        problemContainer.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, padding: .init(top: 60, left: 27, bottom: 0, right: 27), size: .init(width: 336, height: 70))
        problemContainer.layer.cornerRadius = 10
        buttons.anchor(top: problemContainer.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, padding: .init(top: 10, left: 27, bottom: 0, right: 27), size: .init(width: 336, height: 50))
        buttons.layer.cornerRadius = 10
        editButton.widthAnchor.constraint(equalToConstant: 167).isActive = true
        solveButton.widthAnchor.constraint(equalToConstant: 167).isActive = true
        divider.widthAnchor.constraint(equalToConstant: 0.5).isActive = true
        
        controlPanelModal.modalPresentationStyle = .overFullScreen
        controlPanelModal.modalTransitionStyle = .crossDissolve
        controlPanelModal.controlPanel.selectionPicker.addTarget(self, action: #selector(handlePicker), for: .valueChanged)
        controlPanelModal.controlPanel.exprEditor.delegate = self
        controlPanelModal.controlPanel.wrtEditor.addTarget(self, action: #selector(handleWrt), for: .editingChanged)
        controlPanelModal.controlPanel.wrtEditor.delegate = self
        
        solutionModal.modalPresentationStyle = .overFullScreen
        solutionModal.modalTransitionStyle = .crossDissolve
    }
    
    @objc func handleEdit() {
        present(controlPanelModal, animated: true, completion: nil)
    }
    
    @objc func handlePicker() {}
    
    @objc func handleWrt() {
        problemContainer.wrt = controlPanelModal.controlPanel.wrtEditor.text ?? "x"
        updateLatex()
    }
    
    func updateLatex() {}
}

extension CalculusController: MTEditableMathLabelDelegate {
    func textModified(_ label: MTEditableMathLabel!) {
        problemContainer.expr = MTMathListBuilder.mathList(toString: label.mathList)
        updateLatex()
    }
    func returnPressed(_ label: MTEditableMathLabel!) {
        controlPanelModal.dismiss(animated: true, completion: nil)
    }
}

extension CalculusController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        controlPanelModal.dismiss(animated: true, completion: nil)
        return true
    }
}
