//
//  SideMenuViewController.swift
//  ScipyMobile
//
//  Created by Alex Do on 4/4/22.
//

import UIKit

protocol SideMenuDelegate: AnyObject {
    func menuButtonTapped()
    func itemSelected(item: ContentViewControllerPresentation)
}

class SideMenuViewController: UIViewController {
    private var sideMenuItems: [SideMenuItem] = []
    weak var contentViewDelegate: SideMenuDelegate?
    private var leadingConstraint: NSLayoutConstraint!
    
    private var tableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = .lightGray
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.separatorStyle = .none
        tv.bounces = false
        tv.register(SideMenuItemCell.self, forCellReuseIdentifier: SideMenuItemCell.identifier)
        tv.tableFooterView = UIView()
        return tv
    }()
    
    private var sideMenuView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    convenience init(sideMenuItems: [SideMenuItem]) {
        self.init()
        self.sideMenuItems = sideMenuItems
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        view.frame.origin.x = -view.frame.size.width
        
        view.addSubview(sideMenuView)
        sideMenuView.addSubview(tableView)
        
        leadingConstraint = sideMenuView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -view.frame.size.width)
        leadingConstraint.isActive = true
        
        sideMenuView.anchor(top: view.topAnchor, left: nil, bottom: view.bottomAnchor, right: nil)
        sideMenuView.widthAnchor.constraint(equalToConstant: view.frame.size.width * 0.6).isActive = true
        
        tableView.anchor(top: sideMenuView.topAnchor, left: nil, bottom: sideMenuView.bottomAnchor, right: nil)
        tableView.leadingAnchor.constraint(equalTo: sideMenuView.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: sideMenuView.trailingAnchor).isActive = true
        
        tableView.dataSource = self
        tableView.delegate = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapOutsideSideMenu))
        tapGesture.delegate = self
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func handleTapOutsideSideMenu() {
        hide()
    }
    
    func show() {
        view.frame.origin.x = 0
        view.backgroundColor = UIColor(red: 33/255, green: 33/255, blue: 33/255, alpha: 0.5)
        UIView.animate(withDuration: 0.5) {
            self.leadingConstraint.constant = 0
            self.view.layoutIfNeeded()
        }
    }
    
    func hide() {
        view.backgroundColor = .clear
        UIView.animate(withDuration: 0.5) {
            self.leadingConstraint.constant = -self.view.frame.size.width
            self.view.layoutIfNeeded()
        } completion: { _ in
            self.view.frame.origin.x = -self.view.frame.size.width
        }
    }
}

extension SideMenuViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        guard let view = touch.view else { return false }
        return view.isDescendant(of: tableView) ? false : true
    }
}

extension SideMenuViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sideMenuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SideMenuItemCell.identifier, for: indexPath) as? SideMenuItemCell else {
            return UITableViewCell()
        }
        let item = sideMenuItems[indexPath.row]
        cell.configureCell(icon: item.icon, name: item.name, functions: item.functions, contentViewDelegate: contentViewDelegate)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.3) {
            self.tableView.performBatchUpdates(nil)
        }
    }
}
