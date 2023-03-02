//
//  LaunchTableViewCell.swift
//  TestConturAlamofire
//
//  Created by Кирилл Демьянцев on 22.01.2023.
//

import UIKit

class LaunchTableViewCell: UITableViewCell {
    
    static let reuseId = "LaunchTableViewCell"
    
    let backView: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0.2077701986, green: 0.2103852332, blue: 0.2103391886, alpha: 1)
        view.layer.cornerRadius = 30
        return view
    }()
    
    let nameLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 21, weight: .bold)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    let dateLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .gray
        return label
    }()
    
    let imageRocket: UIImageView = {
        var image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupConstraint()
        self.backgroundColor = .black
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func initCell(with data: LaunchInfo) {
        nameLabel.text = data.name
    }
    
    func setupConstraint() {
        self.addSubview(backView)
        backView.addSubview(nameLabel)
        backView.addSubview(dateLabel)
        backView.addSubview(imageRocket)
        
        NSLayoutConstraint.activate([
            
            backView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            backView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25),
            backView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -25),
            backView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            nameLabel.centerYAnchor.constraint(equalTo: backView.centerYAnchor, constant: -15),
            nameLabel.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: imageRocket.leadingAnchor, constant: -5),
            
            dateLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            dateLabel.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 20),
            
            imageRocket.topAnchor.constraint(equalTo: backView.topAnchor, constant: 10),
            imageRocket.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -10),
            imageRocket.heightAnchor.constraint(equalToConstant: 40),
            imageRocket.widthAnchor.constraint(equalToConstant: 40)
            
        ])
    }
}
extension LaunchTableViewCell {
    func configureCell(launch: [LaunchInfo], cell: LaunchTableViewCell, for indexPath: IndexPath) {
        let item = launch[indexPath.row]
        cell.nameLabel.text = "\(item.name)"
        cell.dateLabel.text = item.dateFormatter
        if item.success {
            cell.imageRocket.image = UIImage(named: "true")
        } else {
            cell.imageRocket.image = UIImage(named: "false")
        }
    }
}
