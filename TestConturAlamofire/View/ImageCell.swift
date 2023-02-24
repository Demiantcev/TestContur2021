//
//  ImageCell.swift
//  TestConturAlamofire
//
//  Created by Кирилл Демьянцев on 28.01.2023.
//

import UIKit

protocol PresentSettingVC {
    func presentSetting()
}

class ImageCell: UICollectionViewCell {
    
    static var reuseId = "ImageCell"
    var cellDelegate: PresentSettingVC!
    
    let viewS: UIView = {
        var view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 25
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        return view
    }()
    
    let nameLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 25, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    let imageRocket: UIImageView = {
        var image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    lazy var setupButton: UIButton = {
        var button = UIButton()
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 20, weight: .medium, scale: .large)
        let largeBoldDoc = UIImage(systemName: "gearshape", withConfiguration: largeConfig)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(largeBoldDoc, for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(tapButtonSetting), for: .touchUpInside)
        return button
    }()
    
    @objc func tapButtonSetting(_ sender: UIButton) {
        self.cellDelegate.presentSetting()
    }
    
    var image: UIImage? {
        didSet {
            imageRocket.image = image
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with info: Cell) {
        nameLabel.text = info.value
    }
    
    func setupConstraints() {
        
        addSubview(imageRocket)
        addSubview(setupButton)
        imageRocket.addSubview(viewS)
        viewS.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            
            imageRocket.topAnchor.constraint(equalTo: self.topAnchor),
            imageRocket.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            imageRocket.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageRocket.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            viewS.leadingAnchor.constraint(equalTo: imageRocket.leadingAnchor),
            viewS.trailingAnchor.constraint(equalTo: imageRocket.trailingAnchor),
            viewS.bottomAnchor.constraint(equalTo: imageRocket.bottomAnchor),
            viewS.heightAnchor.constraint(equalToConstant: 100),
            
            nameLabel.topAnchor.constraint(equalTo: viewS.topAnchor, constant: 48),
            nameLabel.leadingAnchor.constraint(equalTo: viewS.leadingAnchor, constant: 32),
            nameLabel.bottomAnchor.constraint(equalTo: viewS.bottomAnchor, constant: -20),
            
            setupButton.topAnchor.constraint(equalTo: viewS.topAnchor, constant: 48),
            setupButton.trailingAnchor.constraint(equalTo: viewS.trailingAnchor, constant: -20),
            setupButton.bottomAnchor.constraint(equalTo: viewS.bottomAnchor, constant: -20)
        ])
    }
}
