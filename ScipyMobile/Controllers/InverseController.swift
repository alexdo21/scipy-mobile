//
//  InverseController.swift
//  ScipyMobile
//
//  Created by Alex Do on 4/14/22.
//

import UIKit

class InverseController: LinearAlgebraController {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Linear Algebra | Inverse of Matrix"
        
        solveButton.configuration?.attributedTitle = AttributedString("Invert", attributes: .init([
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18),
            NSAttributedString.Key.foregroundColor: UIColor.rgb(red: 173, green: 187, blue: 187)
        ]))
        solveButton.addTarget(self, action: #selector(handleInvert), for: .touchUpInside)
    }
    
    @objc func handleInvert() {
        if let matrix = getValidSquareMatrixFromEditor() {
            solutionModal.solutionContainer.solutionView.problem.latex = getMatrixLatex(of: matrix)
            ScipyService.sharedInstance.fetchMatrixInverse(for: matrix) { (response) in
                if let inverse = response {
                    self.solutionModal.solutionContainer.solutionView.solution.latex = self.getMatrixLatex(of: inverse)
                } else {
                    self.solutionModal.solutionContainer.solutionView.solution.latex = "Error\\,unable\\,to\\,fetch"
                }
                self.present(self.solutionModal, animated: true, completion: nil)
            }
        }
    }
}
