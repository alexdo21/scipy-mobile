//
//  DeterminantController.swift
//  ScipyMobile
//
//  Created by Alex Do on 4/14/22.
//

import UIKit

class DeterminantController: LinearAlgebraController {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Linear Algebra | Determinant of Matrix"
        
        solveButton.configuration?.attributedTitle = AttributedString("Determine", attributes: .init([
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18),
            NSAttributedString.Key.foregroundColor: UIColor.rgb(red: 173, green: 187, blue: 187)
        ]))
        solveButton.addTarget(self, action: #selector(handleDetermine), for: .touchUpInside)
        
        solutionModal.solutionContainer.solutionView.problem.fontSize = 30
        solutionModal.solutionContainer.solutionView.solution.fontSize = 30
    }
    
    @objc func handleDetermine() {
        if let matrix = getValidSquareMatrixFromEditor() {
            solutionModal.solutionContainer.solutionView.problem.latex = getMatrixLatex(of: matrix)
            ScipyService.sharedInstance.fetchMatrixDeterminant(for: matrix) { (response) in
                if let determinant = response {
                    self.solutionModal.solutionContainer.solutionView.solution.latex = String(determinant)
                } else {
                    self.solutionModal.solutionContainer.solutionView.solution.latex = "Error\\,unable\\,to\\,fetch"
                }
                self.present(self.solutionModal, animated: true, completion: nil)
            }
        }
    }
}
