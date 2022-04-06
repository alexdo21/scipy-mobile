//
//  SubjectHeaderView.swift
//  ScipyMobile
//
//  Created by Alex Do on 4/6/22.
//

import UIKit

class SubjectHeaderView: UIView {
    private var itemIcon: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private var itemLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var toggleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "chevron.right")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupViews() {
        addSubview(itemIcon)
        addSubview(itemLabel)
        addSubview(toggleImageView)

        itemIcon.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        itemIcon.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true
        itemIcon.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        itemIcon.widthAnchor.constraint(equalToConstant: 25).isActive = true
        itemIcon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
                
        itemLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        itemLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true
        itemLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        itemLabel.leadingAnchor.constraint(equalTo: itemIcon.trailingAnchor, constant: 10).isActive = true
        itemLabel.trailingAnchor.constraint(equalTo: toggleImageView.leadingAnchor).isActive = true
        
        toggleImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        toggleImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true
        toggleImageView.leadingAnchor.constraint(equalTo: itemLabel.trailingAnchor, constant: 10).isActive = true
        toggleImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
    }
    
    func configureView(icon: UIImage?, name: String) {
        itemIcon.image = icon
        itemLabel.text = name
    }
}
