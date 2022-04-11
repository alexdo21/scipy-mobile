//
//  SolutionModalViewController.swift
//  ScipyMobile
//
//  Created by Alex Do on 4/10/22.
//

import UIKit

class SolutionModalViewController: UIViewController {
    let solutionContainer = SolutionContainer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black.withAlphaComponent(0.3)

        view.addSubview(solutionContainer)
        
        solutionContainer.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, padding: .init(top: 359, left: 23, bottom: 155, right: 23), size: .init(width: 344, height: 272))
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapOutsideSolution))
        tapGesture.delegate = self
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func handleTapOutsideSolution() {
        dismiss(animated: true, completion: nil)
    }
}

extension SolutionModalViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        guard let view = touch.view else { return false }
        return view.isDescendant(of: solutionContainer) ? false : true
    }
}
