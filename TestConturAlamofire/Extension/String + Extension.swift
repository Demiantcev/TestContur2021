//
//  String + Extension.swift
//  TestConturAlamofire
//
//  Created by Кирилл Демьянцев on 26.01.2023.
//

import Foundation

// MARK: - Function for date
extension String {
    static func setDateFormat(string: String, fromDate: String) -> String {
        let formatGet = DateFormatter()
        let formatSet = DateFormatter()
        let strDate: String
        formatGet.dateFormat = fromDate
        formatSet.dateFormat = "d MMMM, yyyy"
        guard let date = formatGet.date(from: string) else {
            return "error formatting strToDate"
        }
        strDate = formatSet.string(from: date)
        return strDate
    }
}

enum Params: String {
    case height = "Height"
    case diameter = "Diameter"
    case mass = "Mass"
    case payWeight = "PayloadWeights"
    case m = "m"
    case ft = "ft"
    case kg = "kg"
    case lb = "lb"
}


