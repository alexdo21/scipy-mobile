//
//  SettingsViewController.swift
//  ScipyMobile
//
//  Created by Alex Do on 4/5/22.
//

import UIKit
import MathEditor

class LinearAlgebraController: ContentViewController {
    let container: UIStackView = UIStackView()
    let openBracket = OpenBracket()
    let matrixEditor: UIStackView = UIStackView()
    let closeBracket = CloseBracket()
    
    let dimensionEditor: UIStackView = UIStackView()
    let rowEditor: UITextField = {
        let editor = UITextField()
        editor.backgroundColor = UIColor.rgb(red: 173, green: 187, blue: 187)
        editor.text = "3"
        editor.textColor = .white
        editor.textAlignment = .center
        editor.rightView = UIImageView(image: UIImage(systemName: "chevron.down")?.withTintColor(.white, renderingMode: .alwaysOriginal))
        editor.rightViewMode = .always
        return editor
    }()
    let xLabel: UILabel = {
        let label = UILabel()
        label.text = "x"
        label.textAlignment = .center
        return label
    }()
    let colEditor: UITextField = {
        let editor = UITextField()
        editor.backgroundColor = UIColor.rgb(red: 173, green: 187, blue: 187)
        editor.text = "3"
        editor.textColor = .white
        editor.textAlignment = .center
        editor.rightView = UIImageView(image: UIImage(systemName: "chevron.down")?.withTintColor(.white, renderingMode: .alwaysOriginal))
        editor.rightViewMode = .always
        return editor
    }()
    let rowPicker = UIPickerView()
    let colPicker = UIPickerView()
    let rowToolbar: UIToolbar = {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        return toolbar
    }()
    let colToolbar: UIToolbar = {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        return toolbar
    }()
    
    let solveButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.titlePadding = 5
        let button = UIButton(configuration: config, primaryAction: nil)
        button.backgroundColor = .systemGray5
        button.layer.cornerRadius = 10
        return button
    }()
    
    let squareMatrixErrorAlert: UIAlertController = {
        let alert = UIAlertController(title: "Square Matrix Error", message: "Matrix has to be square", preferredStyle: .alert)
        alert.addAction(.init(title: "OK", style: .default, handler: nil))
        return alert
    }()
    let validMatrixInputErrorAlert: UIAlertController = {
        let alert = UIAlertController(title: "Valid Matrix Input Error", message: "All matrix entries have be filled and be integers", preferredStyle: .alert)
        alert.addAction(.init(title: "OK", style: .default, handler: nil))
        return alert
    }()
    
    let solutionModal = SolutionModalViewController()
    
    var matrixSize: Int = 9
    
    var isSquareMatrix: Bool { return rowEditor.text == colEditor.text }
    
    var tagToTextFieldMap: [Int:UITextField] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(container)
        view.addSubview(dimensionEditor)
        view.addSubview(solveButton)

        configureMatrix()
        configureDimensionEditor()
        
        container.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: nil, bottom: dimensionEditor.topAnchor, right: nil, padding: .init(top: 50, left: 0, bottom: 20, right: 0))
        container.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        dimensionEditor.anchor(top: container.bottomAnchor, left: nil, bottom: solveButton.topAnchor, right: nil, padding: .init(top: 0, left: 0, bottom: 10, right: 0), size: .init(width: 131, height: 23))
        dimensionEditor.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
        solveButton.anchor(top: dimensionEditor.bottomAnchor, left: nil, bottom: nil, right: nil, size: .init(width: 131, height: 30))
        solveButton.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
        
        solutionModal.modalPresentationStyle = .overFullScreen
        solutionModal.modalTransitionStyle = .crossDissolve
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapOutsideMatrixEditor))
        tapGesture.delegate = self
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    func configureMatrix() {
        container.distribution = .fillProportionally
        container.spacing = 5

        matrixEditor.axis = .vertical
        matrixEditor.alignment = .fill
        matrixEditor.distribution = .fillEqually
        matrixEditor.spacing = 15
        configureMatrixSize(row: 3, col: 3)
    }
    
    func configureMatrixSize(row: Int, col: Int) {
        container.removeAllArrangedSubviews()
        matrixEditor.removeAllArrangedSubviews()
        tagToTextFieldMap.removeAll()
        var count: Int = 0
        for _ in 0..<row {
            let rowStackView = UIStackView()
            rowStackView.axis = .horizontal
            rowStackView.alignment = .fill
            rowStackView.distribution = .fillEqually
            rowStackView.spacing = 15
            for _ in 0..<col {
                let entry = MatrixEntry()
                entry.delegate = self
                entry.tag = count
                tagToTextFieldMap[entry.tag] = entry
                count += 1
                rowStackView.addArrangedSubview(entry)
            }
            matrixEditor.addArrangedSubview(rowStackView)
        }
        matrixSize = count
        container.addArrangedSubview(openBracket)
        container.addArrangedSubview(matrixEditor)
        container.addArrangedSubview(closeBracket)
    }
    
    func configureDimensionEditor() {
        dimensionEditor.addArrangedSubview(rowEditor)
        dimensionEditor.addArrangedSubview(xLabel)
        dimensionEditor.addArrangedSubview(colEditor)
        
        dimensionEditor.distribution = .fillProportionally
        
        let flexButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneRowButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneRow))
        rowToolbar.setItems([flexButton, doneRowButton], animated: false)
        rowToolbar.isUserInteractionEnabled = true
        
        let doneColButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneCol))
        colToolbar.setItems([flexButton, doneColButton], animated: false)
        colToolbar.isUserInteractionEnabled = true
        
        rowPicker.delegate = self
        rowPicker.dataSource = self
        rowPicker.tag = 0
        rowPicker.selectRow(2, inComponent: 0, animated: false)
        
        colPicker.delegate = self
        colPicker.dataSource = self
        colPicker.tag = 1
        colPicker.selectRow(2, inComponent: 0, animated: false)
        
        rowEditor.inputView = rowPicker
        rowEditor.inputAccessoryView = rowToolbar
        colEditor.inputView = colPicker
        colEditor.inputAccessoryView = colToolbar
        
        rowEditor.widthAnchor.constraint(equalToConstant: 51).isActive = true
        xLabel.widthAnchor.constraint(equalToConstant: 29).isActive = true
        colEditor.widthAnchor.constraint(equalToConstant: 51).isActive = true
    }
    
    @objc func doneRow() {
        if let row = rowEditor.text, let col = colEditor.text {
            configureMatrixSize(row: Int(row)!, col: Int(col)!)
            rowEditor.resignFirstResponder()
        }
    }
    
    @objc func doneCol() {
        if let row = rowEditor.text, let col = colEditor.text {
            configureMatrixSize(row: Int(row)!, col: Int(col)!)
            colEditor.resignFirstResponder()
        }
    }
    
    @objc func handleTapOutsideMatrixEditor() {
        view.endEditing(true)
    }
    
    func getValidSquareMatrixFromEditor() -> [[Float]]? {
        if !isSquareMatrix {
            self.present(squareMatrixErrorAlert, animated: true)
            return nil
        }
        var matrix: [[Float]] = []
        for i in 0..<matrixEditor.arrangedSubviews.count {
            var row: [Float] = []
            let rowStackView = matrixEditor.arrangedSubviews[i] as! UIStackView
            for j in 0..<rowStackView.arrangedSubviews.count {
                let entryTextField = rowStackView.arrangedSubviews[j] as! UITextField
                if let entryText = entryTextField.text, let entry = Float(entryText) {
                    row.append(entry)
                } else {
                    self.present(validMatrixInputErrorAlert, animated: true)
                    return nil
                }
            }
            matrix.append(row)
        }
        return matrix
    }
    
    func getMatrixLatex(of matrix: [[Float]]) -> String {
        let openTag: String = "\\begin{bmatrix}"
        let closeTag: String = "\\end{bmatrix}"
        
        var rows: [String] = []
        for i in 0..<matrix.count {
            var entries: [String] = []
            for j in 0..<matrix[i].count {
                entries.append(String(matrix[i][j]))
            }
            rows.append(entries.joined(separator: "&"))
        }
        return openTag + rows.joined(separator: "\\\\") + closeTag
    }
}

extension LinearAlgebraController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        tagToTextFieldMap[(textField.tag + 1) % matrixSize]?.becomeFirstResponder()
        return false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
}

extension LinearAlgebraController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        guard let view = touch.view else { return false }
        return view.isDescendant(of: matrixEditor) ? false : true
    }
}
extension LinearAlgebraController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 5
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(row + 1)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 0 {
            rowEditor.text = String(row + 1)
        } else if pickerView.tag == 1 {
            colEditor.text = String(row + 1)
        }
    }
}
