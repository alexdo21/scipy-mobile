//
//  ContentViewController.swift
//  ScipyMobile
//
//  Created by Alex Do on 4/4/22.
//

import UIKit

enum ContentViewControllerPresentation {
    case embed(ContentViewController)
    case push(UIViewController)
    case modal(UIViewController)
}

class ContentViewController: UIViewController {
    weak var sideMenuDelegate: SideMenuDelegate?
    private var barButtonImage: UIImage? = UIImage(systemName: "line.horizontal.3")
    
    convenience init(barButtonImage: UIImage?) {
        self.init()
        self.barButtonImage = barButtonImage
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let barButtonItem = UIBarButtonItem(image: barButtonImage, style: .plain, target: self, action: #selector(handleMenuTapped))
        barButtonItem.tintColor = .white
        navigationItem.setLeftBarButton(barButtonItem, animated: false)
    }
    
    @objc private func handleMenuTapped() {
        sideMenuDelegate?.menuButtonTapped()
    }
}
