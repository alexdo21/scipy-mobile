//
//  ProblemContainer.swift
//  ScipyMobile
//
//  Created by Alex Do on 4/10/22.
//

import UIKit
import MathEditor

class ProblemContainer: UIView {
    var wrt: String = "x"
    var expr: String = "f(x)"
    var atValue: String = "x"
    let expressionLabel: MTMathUILabel = {
        let label = MTMathUILabel()
        label.textColor = .white
        label.font = MTFontManager().xitsFont(withSize: 26)
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
        backgroundColor = UIColor.rgb(red: 173, green: 187, blue: 187)
        addSubview(expressionLabel)
        expressionLabel.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, padding: .init(top: 5, left: 15, bottom: 5, right: 0))
        expressionLabel.latex = "\\frac{\\mathrm{d} }{\\mathrm{d} \(wrt)} (\(expr))"
    }
}
