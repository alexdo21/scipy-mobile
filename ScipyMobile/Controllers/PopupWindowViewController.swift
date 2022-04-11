//
//  PopupWindowViewController.swift
//  ScipyMobile
//
//  Created by Alex Do on 4/6/22.
//

import UIKit

class PopupWindow: UIView {
    let container = UIStackView()
    let symbolicButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.attributedTitle = AttributedString("SYMBOLIC", attributes: .init([
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 24),
            NSAttributedString.Key.foregroundColor: UIColor.rgb(red: 173, green: 187, blue: 187)
        ]))
        config.titlePadding = 5
        let button = UIButton(configuration: config, primaryAction: nil)
        button.contentHorizontalAlignment = .left
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    let separatorView = HorizontalDividerView()
    let solveButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.attributedTitle = AttributedString("SOLVE", attributes: .init([
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 24),
            NSAttributedString.Key.foregroundColor: UIColor.rgb(red: 173, green: 187, blue: 187)
        ]))
        config.titlePadding = 5
        let button = UIButton(configuration: config, primaryAction: nil)
        button.contentHorizontalAlignment = .left
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupViews() {
        container.axis = .vertical
        container.distribution = .fillProportionally
        
        addSubview(container)
        container.addArrangedSubview(symbolicButton)
        container.addArrangedSubview(separatorView)
        container.addArrangedSubview(solveButton)
        
        container.translatesAutoresizingMaskIntoConstraints = false
        separatorView.translatesAutoresizingMaskIntoConstraints = false
                
        container.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
        separatorView.anchor(top: nil, left: container.leftAnchor, bottom: nil, right: container.rightAnchor, padding: .init(top: 0, left: 10, bottom: 0, right: 10))
    }
}

class PopupWindowViewController: UIViewController {
    let popupWindow = PopupWindow()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black.withAlphaComponent(0.3)
        view.isOpaque = false
        
        popupWindow.symbolicButton.addTarget(self, action: #selector(handleSymbolicPressed), for: .touchUpInside)
        popupWindow.solveButton.addTarget(self, action: #selector(handleSolvePressed), for: .touchUpInside)
        
        view.addSubview(popupWindow)
        popupWindow.backgroundColor = .white
        popupWindow.layer.cornerRadius = 10

        popupWindow.translatesAutoresizingMaskIntoConstraints = false
        popupWindow.widthAnchor.constraint(equalToConstant: 344).isActive = true
        popupWindow.heightAnchor.constraint(equalToConstant: 112).isActive = true
        popupWindow.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        popupWindow.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 152).isActive = true
    }
    
    @objc func handleSymbolicPressed() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func handleSolvePressed() {
        self.dismiss(animated: true, completion: nil)
    }
}

class ExampleViewController: ContentViewController {
    let popupWindowVC = PopupWindowViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Popup Window"
        let barButtonItem = UIBarButtonItem(image: UIImage(systemName: "archivebox"), style: .done, target: self, action: #selector(toggleType))
        barButtonItem.tintColor = .white
        navigationItem.rightBarButtonItem = barButtonItem
        popupWindowVC.modalPresentationStyle = .overFullScreen
        popupWindowVC.modalTransitionStyle = .crossDissolve
    }
    
    @objc func toggleType() {
        present(popupWindowVC, animated: true, completion: nil)
    }
}
