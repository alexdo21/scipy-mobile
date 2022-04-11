//
//  ControlPanelModalViewController.swift
//  ScipyMobile
//
//  Created by Alex Do on 4/10/22.
//

import UIKit

class ControlPanelModalViewController: UIViewController {
    let controlPanel = ControlPanel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black.withAlphaComponent(0.3)
        
        view.addSubview(controlPanel)
        controlPanel.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, padding: .init(top: 265, left: 27, bottom: 0, right: 27))
        controlPanel.widthAnchor.constraint(equalToConstant: 336).isActive = true
        controlPanel.layer.cornerRadius = 10
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapOutsideControlPanel))
        tapGesture.delegate = self
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func handleTapOutsideControlPanel() {
        dismiss(animated: true, completion: nil)
    }
}

extension ControlPanelModalViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        guard let view = touch.view else { return false }
        return view.isDescendant(of: controlPanel) ? false : true
    }
}
