//
//  IntegralController.swift
//  ScipyMobile
//
//  Created by Alex Do on 4/10/22.
//

import UIKit

class IntegralController: CalculusController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Calculus | Integral"
        
        problemContainer.expressionLabel.latex = "\\int \\! (\(problemContainer.expr)) \\, \\mathrm{d} \(problemContainer.wrt)"
        
        solveButton.configuration?.attributedTitle = AttributedString("Integrate", attributes: .init([
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18),
            NSAttributedString.Key.foregroundColor: UIColor.rgb(red: 173, green: 187, blue: 187)
        ]))
        solveButton.addTarget(self, action: #selector(handleIntegrate), for: .touchUpInside)
        
        controlPanelModal.controlPanel.configureIntegralControlPanel()
        controlPanelModal.controlPanel.fromEditor.addTarget(self, action: #selector(handleFrom), for: .editingChanged)
        controlPanelModal.controlPanel.fromEditor.delegate = self
        controlPanelModal.controlPanel.toEditor.addTarget(self, action: #selector(handleTo), for: .editingChanged)
        controlPanelModal.controlPanel.toEditor.delegate = self
        
        solutionModal.solutionContainer.solutionView.problem.fontSize = 30
        solutionModal.solutionContainer.solutionView.solution.fontSize = 30
    }
    
    override func handlePicker() {
        if controlPanelModal.controlPanel.selectionPicker.selectedSegmentIndex == 0 {
            controlPanelModal.controlPanel.wrtEditor.placeholder = "with respect to"
            controlPanelModal.controlPanel.divider3.isHidden = true
            controlPanelModal.controlPanel.fromEditor.isHidden = true
            controlPanelModal.controlPanel.divider4.isHidden = true
            controlPanelModal.controlPanel.toEditor.isHidden = true
        } else {
            controlPanelModal.controlPanel.wrtEditor.placeholder = "wrt"
            controlPanelModal.controlPanel.divider3.isHidden = false
            controlPanelModal.controlPanel.fromEditor.isHidden = false
            controlPanelModal.controlPanel.divider4.isHidden = false
            controlPanelModal.controlPanel.toEditor.isHidden = false
        }
        updateLatex()
    }
    
    @objc func handleFrom() {
        problemContainer.from = controlPanelModal.controlPanel.fromEditor.text ?? "a"
        updateLatex()
    }
    
    @objc func handleTo() {
        problemContainer.to = controlPanelModal.controlPanel.toEditor.text ?? "b"
        updateLatex()
    }
    
    override func updateLatex() {
        if controlPanelModal.controlPanel.selectionPicker.selectedSegmentIndex == 0 {
            problemContainer.expressionLabel.latex = "\\int \\! (\(problemContainer.expr)) \\, \\mathrm{d} \(problemContainer.wrt)"
        } else {
            problemContainer.expressionLabel.latex = "\\int_{\(problemContainer.from)}^{\(problemContainer.to)} \\! (\(problemContainer.expr)) \\, \\mathrm{d} \(problemContainer.wrt)"
        }
    }
    
    @objc func handleIntegrate() {
        if let problem = problemContainer.expressionLabel.latex {
            let wrt = problemContainer.wrt
            let expr = problemContainer.expr
            let from = problemContainer.from
            let to = problemContainer.to
            
            solutionModal.solutionContainer.solutionView.problem.latex = problem
            if controlPanelModal.controlPanel.selectionPicker.selectedSegmentIndex == 0 {
                ScipyService.sharedInstance.fetchSymbolicIntegral(for: expr, wrt) { (integral) in
                    self.solutionModal.solutionContainer.solutionView.solution.latex = integral
                    self.present(self.solutionModal, animated: true, completion: nil)
                }
            } else {
                ScipyService.sharedInstance.fetchSolveIntegral(for: expr, wrt, from, to) { (result) in
                    self.solutionModal.solutionContainer.solutionView.solution.latex = result
                    self.present(self.solutionModal, animated: true, completion: nil)
                }
            }
        }
    }
}
