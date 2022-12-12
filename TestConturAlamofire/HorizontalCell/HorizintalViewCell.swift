//
//  HorizintalViewCell.swift
//  TestConturAlamofire
//
//  Created by Кирилл Демьянцев on 06.11.2022.
//

import UIKit

class HorizintalViewCell: UICollectionViewCell {
    
    
    let firstLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont(name: "Arial Bold", size: 17)
       return label
    }()
    
    let secondLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont(name: "Arial Bold", size: 13)
       return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        
        backgroundColor = .gray
        layer.cornerRadius = 30
        
        addSubview(firstLabel)
        addSubview(secondLabel)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            firstLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 28),
            firstLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            firstLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            firstLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -44),
            
            secondLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 52),
            secondLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            secondLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            secondLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -24)
        ])
    }
}
