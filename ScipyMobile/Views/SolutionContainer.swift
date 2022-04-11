//
//  SolutionContainer.swift
//  ScipyMobile
//
//  Created by Alex Do on 4/10/22.
//

import UIKit

class SolutionContainer: UIView {
    let solutionLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.text = "SOLUTION"
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = .white
        return label
    }()
    let solutionView = SolutionView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupViews() {
        let container = UIStackView(arrangedSubviews: [solutionLabel, solutionView])
        container.axis = .vertical
        container.distribution = .fillProportionally
        
        addSubview(container)
        container.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
        solutionLabel.heightAnchor.constraint(equalToConstant: 39).isActive = true
        solutionView.heightAnchor.constraint(equalToConstant: 233).isActive = true
        solutionView.layer.cornerRadius = 25
    }
}

