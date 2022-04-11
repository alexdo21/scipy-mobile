//
//  ContainerViewComposer.swift
//  ScipyMobile
//
//  Created by Alex Do on 4/10/22.
//

import UIKit

class ContainerViewComposer {
    static func makeContainer() -> ContainerViewController {
        let landingPageVC = LandingPageViewController()
        let derivativeVC = DerivativeController()
        let integralVC = IntegralController()
        let linearAlgebraVC = LinearAlgebraController()
        let sideMenuItems = [
            SideMenuItem(icon: UIImage(systemName: "function")?.withTintColor(.black, renderingMode: .alwaysOriginal),
                         name: "Calculus",
                         functions: [
                            Function(name: "Derivative", viewController: .embed(derivativeVC)),
                            Function(name: "Integral", viewController: .embed(integralVC))
                         ]),
            SideMenuItem(icon: UIImage(systemName: "square.grid.3x3")?.withTintColor(.black, renderingMode: .alwaysOriginal),
                         name: "Linear Algebra",
                         functions: [
                            Function(name: "Matrix Inverse", viewController: .embed(linearAlgebraVC)),
                            Function(name: "Matrix Determinant", viewController: .embed(linearAlgebraVC))
                         ]),
//            SideMenuItem(icon: UIImage(systemName: "cart")?.withTintColor(.black, renderingMode: .alwaysOriginal),
//                         name: "Examples",
//                         functions: [
//                         ])
        ]
        let sideMenuItemViewController = SideMenuViewController(sideMenuItems: sideMenuItems)
        let container = ContainerViewController(sideMenuViewController: sideMenuItemViewController, rootViewController: landingPageVC)
        return container
    }
}
