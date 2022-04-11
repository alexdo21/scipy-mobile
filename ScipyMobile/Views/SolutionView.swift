//
//  SolutionView.swift
//  ScipyMobile
//
//  Created by Alex Do on 4/10/22.
//

import UIKit
import MathEditor

class SolutionView: UIView {
    let problem: MTMathUILabel = {
        let label = MTMathUILabel()
        label.textColor = UIColor.rgb(red: 173, green: 187, blue: 187)
        label.font = MTFontManager().xitsFont(withSize: 30)
        return label
    }()
    let arrow: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = UIImage(systemName: "arrow.down")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        return iv
    }()
    let solution: MTMathUILabel = {
        let label = MTMathUILabel()
        label.textColor = UIColor.rgb(red: 173, green: 187, blue: 187)
        label.font = MTFontManager().xitsFont(withSize: 30)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupViews() {
        let container = UIStackView(arrangedSubviews: [problem, arrow, solution])
        container.axis = .vertical
        container.distribution = .fillProportionally
        
        addSubview(container)
        backgroundColor = .white
        
        container.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
        problem.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.95).isActive = true
        problem.heightAnchor.constraint(equalToConstant: 104.85).isActive = true
        arrow.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.1).isActive = true
        arrow.heightAnchor.constraint(equalToConstant: 23.3).isActive = true
        solution.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.95).isActive = true
        solution.heightAnchor.constraint(equalToConstant: 104.85).isActive = true
    }
}
