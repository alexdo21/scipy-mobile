//
//  ContainerViewController.swift
//  ScipyMobile
//
//  Created by Alex Do on 4/4/22.
//

import UIKit

class ContainerViewComposer {
    static func makeContainer() -> ContainerViewController {
        let calculusVC = CalculusController()
        let sideMenuItems = [
            SideMenuItem(icon: UIImage(systemName: "function")?.withTintColor(.white, renderingMode: .alwaysOriginal),
                         name: "Calculus",
                         functions: [
                            Function(name: "Derivative", viewController: .embed(calculusVC)),
                            Function(name: "Integral", viewController: .embed(calculusVC))
                         ]),
            SideMenuItem(icon: UIImage(systemName: "number")?.withTintColor(.white, renderingMode: .alwaysOriginal),
                         name: "Linear Algebra",
                         functions: [
                            Function(name: "Matrix Inverse", viewController: .embed(calculusVC)),
                            Function(name: "Matrix Determinant", viewController: .embed(calculusVC))
                         ])

        ]
        let sideMenuItemViewController = SideMenuViewController(sideMenuItems: sideMenuItems)
        let container = ContainerViewController(sideMenuViewController: sideMenuItemViewController, rootViewController: calculusVC)
        return container
    }
}

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
