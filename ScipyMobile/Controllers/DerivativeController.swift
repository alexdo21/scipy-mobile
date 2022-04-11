//
//  DerivativeController.swift
//  ScipyMobile
//
//  Created by Alex Do on 3/19/22.
//

import UIKit

class DerivativeController: CalculusController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Calculus | Derivative"
        
        problemContainer.expressionLabel.latex = "\\frac{\\mathrm{d} }{\\mathrm{d} \(problemContainer.wrt)} (\(problemContainer.expr))"
        
        solveButton.configuration?.attributedTitle = AttributedString("Derive", attributes: .init([
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18),
            NSAttributedString.Key.foregroundColor: UIColor.rgb(red: 173, green: 187, blue: 187)
        ]))
        solveButton.addTarget(self, action: #selector(handleDerive), for: .touchUpInside)
        
        controlPanelModal.controlPanel.configureDerivativeControlPanel()
        controlPanelModal.controlPanel.atValueEditor.addTarget(self, action: #selector(handleAtValue), for: .editingChanged)
        controlPanelModal.controlPanel.atValueEditor.delegate = self
    }
    
    override func handlePicker() {
        if controlPanelModal.controlPanel.selectionPicker.selectedSegmentIndex == 0 {
            controlPanelModal.controlPanel.divider2.isHidden = true
            controlPanelModal.controlPanel.atValueEditor.isHidden = true
        } else {
            controlPanelModal.controlPanel.divider2.isHidden = false
            controlPanelModal.controlPanel.atValueEditor.isHidden = false
        }
        updateLatex()
    }
    
    @objc func handleAtValue() {
        problemContainer.atValue = controlPanelModal.controlPanel.atValueEditor.text ?? "0"
        updateLatex()
    }
    
    override func updateLatex() {
        if controlPanelModal.controlPanel.selectionPicker.selectedSegmentIndex == 0 {
            problemContainer.expressionLabel.latex = "\\frac{\\mathrm{d} }{\\mathrm{d} \(problemContainer.wrt)} (\(problemContainer.expr))"
        } else {
            problemContainer.expressionLabel.latex = "\\left. \\frac{\\mathrm{d} }{\\mathrm{d} \(problemContainer.wrt)} (\(problemContainer.expr)) \\right\\vert_{\(problemContainer.wrt)=\(problemContainer.atValue)}"
        }
    }
    
    @objc func handleDerive() {
        if let problem = problemContainer.expressionLabel.latex {
            let wrt = problemContainer.wrt
            let expr = problemContainer.expr
            let value = problemContainer.atValue
            
            solutionModal.solutionContainer.solutionView.problem.latex = problem
            
            if controlPanelModal.controlPanel.selectionPicker.selectedSegmentIndex == 0 {
                ScipyService.sharedInstance.fetchSymbolicDerivative(for: expr, wrt) { (derivative) in
                    self.solutionModal.solutionContainer.solutionView.solution.latex = derivative
                }
            } else {
                ScipyService.sharedInstance.fetchSymbolicDerivative(for: expr, wrt) { (derivative) in
                    self.solutionModal.solutionContainer.solutionView.solution.latex = value
                }
            }
            present(solutionModal, animated: true, completion: nil)
        }
    }
}

