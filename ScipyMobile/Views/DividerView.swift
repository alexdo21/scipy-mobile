//
//  DividerView.swift
//  ScipyMobile
//
//  Created by Alex Do on 4/10/22.
//

import UIKit

class VerticalDividerView: UIView {
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
        backgroundColor = UIColor.rgb(red: 183, green: 183, blue: 183)
    }

    override var intrinsicContentSize: CGSize {
        return CGSize(width: 0.5, height: UIView.noIntrinsicMetric)
    }
}

class HorizontalDividerView: UIView {
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
        backgroundColor = UIColor.rgb(red: 183, green: 183, blue: 183)
    }

    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: 0.5)
    }
}
