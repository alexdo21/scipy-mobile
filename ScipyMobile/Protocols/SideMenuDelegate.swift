//
//  SideMenuDelegate.swift
//  ScipyMobile
//
//  Created by Alex Do on 4/10/22.
//

protocol SideMenuDelegate: AnyObject {
    func menuButtonTapped()
    func itemSelected(item: ContentViewControllerPresentation)
}
