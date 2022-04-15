//
//  BracketView.swift
//  ScipyMobile
//
//  Created by Alex Do on 4/14/22.
//

import UIKit

class OpenBracket: UIView {
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
        addBorders(to: [.top, .left, .bottom], in: .black, width: 2)
    }

    override var intrinsicContentSize: CGSize {
        return CGSize(width: 10, height: UIView.noIntrinsicMetric)
    }
}

class CloseBracket: UIView {
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
        addBorders(to: [.top, .right, .bottom], in: .black, width: 2)
    }

    override var intrinsicContentSize: CGSize {
        return CGSize(width: 10, height: UIView.noIntrinsicMetric)
    }
}
