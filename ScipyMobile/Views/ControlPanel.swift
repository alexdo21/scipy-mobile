//
//  ControlPanel.swift
//  ScipyMobile
//
//  Created by Alex Do on 4/10/22.
//

import UIKit
import MathEditor

class ControlPanel: UIView {
    let controlPanelContainer = UIStackView()
    let selectionPicker: UISegmentedControl = {
        let picker = UISegmentedControl(items: ["Symbolic", "Solve"])
        picker.selectedSegmentTintColor = UIColor.themeColor()
        picker.selectedSegmentIndex = 0
        return picker
    }()
    
    let exprEditor: MTEditableMathLabel = {
        let editor = MTEditableMathLabel()
        editor.backgroundColor = .clear
        editor.mathList = MTMathListBuilder.build(from: "f(x)")
        return editor
    }()
    
    let wrtEditor: UITextField = {
        let editor = UITextField()
        editor.textContentType = .password
        editor.textAlignment = .center
        editor.autocapitalizationType = .none
        editor.placeholder = "with respect to"
        return editor
    }()
    
    let atValueEditor: UITextField = {
        let editor = UITextField()
        editor.textContentType = .password
        editor.textAlignment = .center
        editor.autocapitalizationType = .none
        editor.placeholder = "at value"
        return editor
    }()
    
    let divider1 = HorizontalDividerView()
    let divider2 = VerticalDividerView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupViews() {
        backgroundColor = .white
        addSubview(controlPanelContainer)
        controlPanelContainer.axis = .vertical
        controlPanelContainer.distribution = .fillProportionally
        
        controlPanelContainer.addArrangedSubview(selectionPicker)
        controlPanelContainer.addArrangedSubview(exprEditor)
        controlPanelContainer.addArrangedSubview(divider1)
        
        let bottomContainer = UIStackView(arrangedSubviews: [wrtEditor, divider2, atValueEditor])
        bottomContainer.distribution = .fillProportionally
        controlPanelContainer.addArrangedSubview(bottomContainer)
        
        selectionPicker.heightAnchor.constraint(equalToConstant: 50).isActive = true
        exprEditor.heightAnchor.constraint(equalToConstant: 50).isActive = true
        wrtEditor.heightAnchor.constraint(equalToConstant: 50).isActive = true
        atValueEditor.heightAnchor.constraint(equalToConstant: 50).isActive = true
        atValueEditor.widthAnchor.constraint(equalToConstant: 167).isActive = true
        
        divider1.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        divider2.widthAnchor.constraint(equalToConstant: 0.5).isActive = true
        
        controlPanelContainer.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
        
        atValueEditor.isHidden = true
        divider2.isHidden = true
    }
}
