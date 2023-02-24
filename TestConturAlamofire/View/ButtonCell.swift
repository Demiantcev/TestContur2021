//
//  ButtonCell.swift
//  TestConturAlamofire
//
//  Created by Кирилл Демьянцев on 29.01.2023.
//

import UIKit

protocol PresentLaunchVC {
    func presentLaunch()
}

class ButtonCell: UICollectionViewCell {
    
    static var reuseId = "ButtonCell"
    var delegate: PresentLaunchVC!
    
    let cellView: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var launchButton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Посмотреть запуски", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.2077701986, green: 0.2103852332, blue: 0.2103391886, alpha: 1)
        button.layer.cornerRadius = 18
        button.titleLabel?.font = UIFont(name: "AvenirNext-Bold", size: 20)
        button.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        return button
    }()
    
    @objc func tapButton() {
        self.delegate.presentLaunch()
        }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        
        addSubview(cellView)
        cellView.addSubview(launchButton)
        
        NSLayoutConstraint.activate([
            
            cellView.topAnchor.constraint(equalTo: self.topAnchor),
            cellView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            cellView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            cellView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            launchButton.topAnchor.constraint(equalTo: self.topAnchor),
            launchButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            launchButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            launchButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20)
        
        ])
    }
}
