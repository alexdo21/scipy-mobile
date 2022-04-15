//
//  MatrixEntryView.swift
//  ScipyMobile
//
//  Created by Alex Do on 4/14/22.
//

import UIKit

class MatrixEntry: UITextField {
    init() {
        super.init(frame: .zero)
        setupViews()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        textAlignment = .center
        placeholder = "?"
        textColor = .white
        font = UIFont.systemFont(ofSize: 30)
        adjustsFontSizeToFitWidth = true
        minimumFontSize = 10
        backgroundColor = UIColor.rgb(red: 173, green: 187, blue: 187)
    }

    override var intrinsicContentSize: CGSize {
        return CGSize(width: 48, height: 48)
    }
}
