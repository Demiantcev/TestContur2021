//
//  HorizontalViewCell.swift
//  TestConturAlamofire
//
//  Created by Кирилл Демьянцев on 06.11.2022.
//

import UIKit

class HorizontalViewCell: UICollectionViewCell {
    
    static var reuseId = "HorizontalViewCell"
    
    let cellView: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0.1294117868, green: 0.1294117868, blue: 0.1294117868, alpha: 1)
        view.layer.cornerRadius = 30
        return view
    }()
    
    let firstLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont(name: "Arial Bold", size: 19)
        return label
    }()
    
    let secondLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.8470588235)
        label.font = UIFont(name: "Arial Bold", size: 14)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: Cell) {
        self.firstLabel.text = model.value
        self.secondLabel.text = model.title
    }
    
    private func setConstraints() {
        
        addSubview(cellView)
        cellView.addSubview(firstLabel)
        cellView.addSubview(secondLabel)
        
        NSLayoutConstraint.activate([
            
            cellView.topAnchor.constraint(equalTo: self.topAnchor),
            cellView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            cellView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            cellView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            firstLabel.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 28),
            firstLabel.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 8),
            firstLabel.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -8),
            firstLabel.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -44),
            
            secondLabel.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 52),
            secondLabel.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 8),
            secondLabel.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -8),
            secondLabel.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -24)
        ])
    }
}
