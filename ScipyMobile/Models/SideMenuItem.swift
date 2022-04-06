//
//  SideMenuItem.swift
//  ScipyMobile
//
//  Created by Alex Do on 4/4/22.
//

import UIKit

struct Function {
    let name: String
    let viewController: ContentViewControllerPresentation
}

struct SideMenuItem {
    let icon: UIImage?
    let name: String
    let functions: [Function]
}
