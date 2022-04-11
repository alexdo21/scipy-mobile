//
//  LandingViewController.swift
//  ScipyMobile
//
//  Created by Alex Do on 4/6/22.
//

import UIKit

class LandingPageViewController: ContentViewController {
    let welcomeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "welcome to scipy"
        label.font = UIFont.systemFont(ofSize: 40, weight: .regular)
        label.textColor = UIColor.rgb(red: 146, green: 158, blue: 158)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(welcomeLabel)
        welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        welcomeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 155).isActive = true
    }
}
