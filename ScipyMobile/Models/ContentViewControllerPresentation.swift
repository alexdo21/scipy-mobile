//
//  ContentViewControllerPresentation.swift
//  ScipyMobile
//
//  Created by Alex Do on 4/10/22.
//

import UIKit

enum ContentViewControllerPresentation {
    case embed(ContentViewController)
    case push(UIViewController)
    case modal(UIViewController)
}
