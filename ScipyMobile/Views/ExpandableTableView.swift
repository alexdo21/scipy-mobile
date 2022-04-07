//
//  ExpandableTableView.swift
//  ScipyMobile
//
//  Created by Alex Do on 4/6/22.
//

import UIKit

class ExpandableTableView: UIView {
    private weak var contentViewDelegate: SideMenuDelegate?
    private var functions: [Function]!
    
    private let tableView: IntrinsicTableView = {
        let tv = IntrinsicTableView()
        tv.backgroundColor = UIColor.themeColor()
        tv.register(FunctionCell.self, forCellReuseIdentifier: FunctionCell.identifier)
        return tv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupViews() {
        tableView.dataSource = self
        tableView.delegate = self

        addSubview(tableView)

        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 47).isActive = true
        tableView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        tableView.separatorStyle = .none
        
        heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func configureView(functions: [Function], contentViewDelegate: SideMenuDelegate?) {
        self.functions = functions
        self.contentViewDelegate = contentViewDelegate
    }
}

extension ExpandableTableView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return functions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FunctionCell.identifier, for: indexPath) as? FunctionCell else { return UITableViewCell() }
        
        let function = functions[indexPath.row]
        cell.selectionStyle = .none
        cell.configureCell(name: function.name, viewController: function.viewController)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = functions[indexPath.row]
        contentViewDelegate?.itemSelected(item: item.viewController)
    }
}
