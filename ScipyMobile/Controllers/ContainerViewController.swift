//
//  ContainerViewController.swift
//  ScipyMobile
//
//  Created by Alex Do on 4/4/22.
//

import UIKit

class ContainerViewController: UIViewController {
    private var sideMenuViewController: SideMenuViewController!
    private var navigator: UINavigationController!
    private var rootViewController: ContentViewController! {
        didSet {
            rootViewController.sideMenuDelegate = self
            navigator.setViewControllers([rootViewController], animated: false)
        }
    }
    
    convenience init(sideMenuViewController: SideMenuViewController, rootViewController: ContentViewController) {
        self.init()
        self.sideMenuViewController = sideMenuViewController
        self.rootViewController = rootViewController
        self.navigator = UINavigationController(rootViewController: rootViewController)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChild(navigator)
        view.addSubview(navigator.view)
        navigator.didMove(toParent: self)
        
        let barAppearance = UINavigationBarAppearance()
        barAppearance.backgroundColor = UIColor.rgb(red: 116, green: 157, blue: 157)
        barAppearance.titleTextAttributes = [.font: UIFont.systemFont(ofSize: 16), .foregroundColor: UIColor.white]
        navigator.navigationBar.standardAppearance = barAppearance
        navigator.navigationBar.scrollEdgeAppearance = barAppearance
        
        addChild(sideMenuViewController)
        view.addSubview(sideMenuViewController.view)
        sideMenuViewController.didMove(toParent: self)
        
        sideMenuViewController.contentViewDelegate = self
        rootViewController.sideMenuDelegate = self
    }
    
    func updateRootViewController(_ viewController: ContentViewController) {
        rootViewController = viewController
    }
}

extension ContainerViewController: SideMenuDelegate {
    func menuButtonTapped() {
        sideMenuViewController.show()
    }
    
    func itemSelected(item: ContentViewControllerPresentation) {
        switch item {
        case let .embed(viewController):
            updateRootViewController(viewController)
        case let .push(viewController):
            navigator.pushViewController(viewController, animated: true)
        case let .modal(viewController):
            navigator.present(viewController, animated: true)
        }
        sideMenuViewController.hide()
    }
}
