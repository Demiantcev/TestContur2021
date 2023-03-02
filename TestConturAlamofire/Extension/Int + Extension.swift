//
//  Int + Extension.swift
//  TestConturAlamofire
//
//  Created by Кирилл Демьянцев on 26.01.2023.
//

import Foundation

// MARK: - Function for price
extension Int {
    static func formatPoints(from: Int) -> String {
        
        let number = Int(from)
        let million = number / 1000000
        
        if million >= 7 {
            return "$\((million * 10)/10) млн"
        } else {
            return "$\(Double(number) / 1000000) млн"
        }
    }
}
