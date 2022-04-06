//
//  FunctionCell.swift
//  ScipyMobile
//
//  Created by Alex Do on 4/6/22.
//

import UIKit

class FunctionCell: UITableViewCell {
    static var identifier: String { String(describing: self) }
    
    private let name: UILabel = UILabel()
    private var viewController: ContentViewControllerPresentation?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: FunctionCell.identifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupViews() {
        contentView.backgroundColor = .lightGray
        contentView.addSubview(name)
        name.translatesAutoresizingMaskIntoConstraints = false
        name.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        name.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        name.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        name.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        name.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
    
    func configureCell(name: String, viewController: ContentViewControllerPresentation) {
        self.name.text = "• \(name)"
        self.name.font = UIFont.systemFont(ofSize: 14)
        self.viewController = viewController
    }
}
