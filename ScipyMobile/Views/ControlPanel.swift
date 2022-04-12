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
    
    let wrtEditor: UITextField = UITextField.makeCustomControlPanelUITextField(placeholder: "with respect to", textContentType: .username)
    
    let atValueEditor: UITextField = UITextField.makeCustomControlPanelUITextField(placeholder: "at value", textContentType: .creditCardNumber)
    
    let fromEditor: UITextField = UITextField.makeCustomControlPanelUITextField(placeholder: "from", textContentType: .creditCardNumber)
    
    let toEditor: UITextField = UITextField.makeCustomControlPanelUITextField(placeholder: "to", textContentType: .creditCardNumber)
    
    let divider1 = HorizontalDividerView()
    let divider2 = VerticalDividerView()
    let divider3 = VerticalDividerView()
    let divider4 = VerticalDividerView()
    
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
        
        selectionPicker.heightAnchor.constraint(equalToConstant: 50).isActive = true
        exprEditor.heightAnchor.constraint(equalToConstant: 50).isActive = true
        wrtEditor.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        divider1.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        
        controlPanelContainer.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
    }
    
    func configureDerivativeControlPanel() {
        let bottomContainer = UIStackView(arrangedSubviews: [wrtEditor, divider2, atValueEditor])
        bottomContainer.distribution = .fillProportionally
        controlPanelContainer.addArrangedSubview(bottomContainer)
        atValueEditor.heightAnchor.constraint(equalToConstant: 50).isActive = true
        atValueEditor.widthAnchor.constraint(equalToConstant: 167).isActive = true
        divider2.widthAnchor.constraint(equalToConstant: 0.5).isActive = true
        divider2.isHidden = true
        atValueEditor.isHidden = true
    }
    
    func configureIntegralControlPanel() {
        let bottomContainer = UIStackView(arrangedSubviews: [wrtEditor, divider3, fromEditor, divider4, toEditor])
        controlPanelContainer.addArrangedSubview(bottomContainer)
        fromEditor.heightAnchor.constraint(equalToConstant: 50).isActive = true
        fromEditor.widthAnchor.constraint(equalToConstant: 111.66).isActive = true
        toEditor.heightAnchor.constraint(equalToConstant: 50).isActive = true
        toEditor.widthAnchor.constraint(equalToConstant: 111.66).isActive = true
        divider3.widthAnchor.constraint(equalToConstant: 0.5).isActive = true
        divider4.widthAnchor.constraint(equalToConstant: 0.5).isActive = true
        
        divider3.isHidden = true
        fromEditor.isHidden = true
        toEditor.isHidden = true
        divider4.isHidden = true
    }
}
