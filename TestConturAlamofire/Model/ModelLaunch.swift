//
//  ModelLaunch.swift
//  TestConturAlamofire
//
//  Created by Кирилл Демьянцев on 26.01.2023.
//

import Foundation

struct LaunchInfo {
    let name: String
    let success: Bool
    let date: String
    let rocket: String
    
    var dateFormatter: String {
        String.setDateFormat(string: date, fromDate: "yyyy-MM-dd'T'HH:mm:ssZ")
    }
    
    enum CodingKeys: String, CodingKey {
        case date = "date_local"
    }
    init?(json: [String: Any]) {
        guard
            let nameJson = json["name"] as? String,
            let successJson = json["success"] as? Bool,
            let dateJson = json["date_local"] as? String,
            let rocketJson = json["rocket"] as? String
        else {
            return nil
        }
        self.name = nameJson
        self.success = successJson
        self.date = dateJson
        self.rocket = rocketJson
    }
    static func getArray(from jsonArray: Any) -> [LaunchInfo]? {
        
        guard let jsonArray = jsonArray as? [[String: Any]] else { return nil }
        
        var launchArray: [LaunchInfo] = []
        
        for jsonObject in jsonArray {
            if let launch = LaunchInfo(json: jsonObject) {
                launchArray.append(launch)
            }
        }
        return launchArray
    }
}
