//
//  SideMenuItemCell.swift
//  ScipyMobile
//
//  Created by Alex Do on 4/5/22.
//

import UIKit

class SideMenuItemCell: UITableViewCell {
    static var identifier: String {
        String(describing: self)
    }
    
    var isExpandableTableViewHidden: Bool {
        return expandableTableView.isHidden
    }
        
    private let containerView = UIStackView()
    private let subjectHeader = SubjectHeaderView()
    private let expandableTableView = ExpandableTableView()
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: SideMenuItemCell.identifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupViews() {
        selectionStyle = .none
        
        expandableTableView.isHidden = true
        containerView.axis = .vertical
        
        contentView.backgroundColor = .lightGray
        contentView.addSubview(containerView)
        containerView.addArrangedSubview(subjectHeader)
        containerView.addArrangedSubview(expandableTableView)
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        subjectHeader.translatesAutoresizingMaskIntoConstraints = false
        expandableTableView.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
    }
    
    func configureCell(icon: UIImage?, name: String, functions: [Function], contentViewDelegate: SideMenuDelegate?) {
        subjectHeader.configureView(icon: icon, name: name)
        expandableTableView.configureView(functions: functions, contentViewDelegate: contentViewDelegate)
    }
    
    func showExpandableTableView() {
        subjectHeader.toggleImageView.image = UIImage(systemName: "chevron.down")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        expandableTableView.isHidden = false
    }
    
    func hideExpandableTableView() {
        subjectHeader.toggleImageView.image = UIImage(systemName: "chevron.right")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        expandableTableView.isHidden = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if isExpandableTableViewHidden, selected {
            showExpandableTableView()
        } else if !isExpandableTableViewHidden, selected {
            hideExpandableTableView()
        }
    }
}
