//
//  ExpandableTableView.swift
//  ScipyMobile
//
//  Created by Alex Do on 4/6/22.
//

import UIKit

final class IntrinsicTableView: UITableView {
    override var contentSize: CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }
    override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
    }
}
