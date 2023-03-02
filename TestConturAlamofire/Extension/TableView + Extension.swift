//
//  TableView + Extension.swift
//  TestConturAlamofire
//
//  Created by Кирилл Демьянцев on 04.02.2023.
//

import UIKit

extension UITableView {
    func emptyLabel(_ message: String) {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        label.font = .systemFont(ofSize: 25, weight: .bold)
        label.textColor = .white
        label.text = message
        label.numberOfLines = 0
        label.sizeToFit()
        label.textAlignment = .center
        self.backgroundView = label
        self.separatorStyle = .none
    }
    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}

