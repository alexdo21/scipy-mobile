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
    var from: String = "a"
    var to: String = "b"
    let expressionLabel: MTMathUILabel = {
        let label = MTMathUILabel()
        label.textColor = .white
        label.font = MTFontManager().xitsFont(withSize: 24)
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
        expressionLabel.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, padding: .init(top: 0, left: 15, bottom: 0, right: 0))
    }
}
