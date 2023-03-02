//
//  VerticalCell.swift
//  TestConturAlamofire
//
//  Created by Кирилл Демьянцев on 29.01.2023.
//

import UIKit

class VerticalCell: UICollectionViewCell {
    
    static var reuseId = "VerticalCell"
    
    let cellView: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let leftLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()
    
    let rightLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "nil"
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
    
    func configure(with info: Cell) {
        leftLabel.text = info.title
        rightLabel.text = info.value
    }
    
    func setupConstraints() {
        addSubview(cellView)
        cellView.addSubview(leftLabel)
        cellView.addSubview(rightLabel)
        
        NSLayoutConstraint.activate([
            
            cellView.topAnchor.constraint(equalTo: self.topAnchor),
            cellView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            cellView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            cellView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            leftLabel.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 10),
            leftLabel.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 10),
            leftLabel.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -10),
            
            rightLabel.topAnchor.constraint(equalTo: leftLabel.topAnchor),
            rightLabel.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -10),
            rightLabel.bottomAnchor.constraint(equalTo: leftLabel.bottomAnchor)
            
        ])
    }
}
