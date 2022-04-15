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
        label.font = MTFontManager().xitsFont(withSize: 18)
        return label
    }()
    let arrow: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .left
        let arrowImage = UIImage(systemName: "arrow.down")?.withTintColor(.black, renderingMode: .alwaysOriginal).withAlignmentRectInsets(.init(top: -5, left: -10, bottom: -10, right: -10))
        iv.image = arrowImage
        return iv
    }()
    let solution: MTMathUILabel = {
        let label = MTMathUILabel()
        label.textColor = UIColor.rgb(red: 173, green: 187, blue: 187)
        label.font = MTFontManager().xitsFont(withSize: 18)
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
        container.distribution = .equalCentering
        
        addSubview(container)
        backgroundColor = .white
        
        container.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
        problem.anchor(top: container.topAnchor, left: container.leftAnchor, bottom: container.arrangedSubviews[1].topAnchor, right: container.rightAnchor, padding: .init(top: 0, left: 30, bottom: 0, right: 0))
        arrow.heightAnchor.constraint(equalToConstant: 35).isActive = true
        arrow.centerXAnchor.constraint(equalTo: problem.centerXAnchor).isActive = true
        solution.anchor(top: container.arrangedSubviews[1].bottomAnchor, left: container.leftAnchor, bottom: container.bottomAnchor, right: container.rightAnchor, padding: .init(top: 0, left: 30, bottom: 0, right: 0))
    }
}
