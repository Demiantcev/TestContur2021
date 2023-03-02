//
//  StageHeaderCell.swift
//  TestConturAlamofire
//
//  Created by Кирилл Демьянцев on 29.01.2023.
//

import UIKit

class StageHeaderCell: UICollectionReusableView {
    
    static var reuseId = "StageHeaderCell"
    
    let headerStageLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 23, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with title: String) {
        headerStageLabel.text = title
    }
    
    func setupConstraints() {
        
        addSubview(headerStageLabel)
        
        NSLayoutConstraint.activate([
            
            headerStageLabel.topAnchor.constraint(equalTo: self.topAnchor),
            headerStageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            headerStageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            headerStageLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            
        ])
    }
}
