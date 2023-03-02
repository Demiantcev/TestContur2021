//
//  Model.swift
//  TestConturAlamofire
//
//  Created by Кирилл Демьянцев on 27.10.2022.
//

import Foundation
import SwiftyJSON

struct RocketInfo: Hashable {
    
    let height: Height
    let diameter: Diameter
    let mass: Mass
    let payloadWeights: [PayloadWeight]
    let flickrImages: [String]
    let name: String
    let firstFlight: String
    let country: String
    let costPerLaunch: Int
    let firstStage: FirstStage
    let secondStage: SecondStage
    let id: String
    
    var firstFlightFormatter: String {
        String.setDateFormat(string: firstFlight, fromDate: "yyyy-MM-dd")
    }
    
    var launchCost: String {
        Int.formatPoints(from: costPerLaunch)
    }
    
    var countryString: String {
        switch country {
        case "Republic of the Marshall Islands" : return "Маршалловы о-ва"
        case "United States"                    : return "США"
            
        default:
            return "Загрузка..."
        }
    }
    
    init?(json: [String: Any]) {
        guard
            let flickrImages = json["flickr_images"] as? [String],
            let name = json["name"] as? String,
            let firstFlight = json["first_flight"] as? String,
            let country = json["country"] as? String,
            let costPerLaunch = json["cost_per_launch"] as? Int,
            let firstStageJson = json["first_stage"] as? [String: Any],
            let secondStageJson = json["second_stage"] as? [String: Any],
            let heightJson = json["height"] as? [String: Any],
            let massJson = json["mass"] as? [String: Any],
            let diameterJson = json["diameter"] as? [String: Any],
            let idJson = json["id"] as? String,
            let payloadWeightJson = json["payload_weights"] as? [[String: Any]] else { return nil }
        var payload = [PayloadWeight]()
        payloadWeightJson.forEach { value in
            guard let json = PayloadWeight(data: value) else { return }
            payload.append(json)
        }
        
        self.flickrImages = flickrImages
        self.name = name
        self.firstFlight = firstFlight
        self.country = country
        self.costPerLaunch = costPerLaunch
        self.firstStage = FirstStage(json: firstStageJson)
        self.secondStage = SecondStage(json: secondStageJson)
        self.height = Height(json: heightJson)
        self.mass = Mass(json: massJson)
        self.diameter = Diameter(json: diameterJson)
        self.payloadWeights = payload
        self.id = idJson
    }
    
    static func getArray(from jsonArray: Any) -> [RocketInfo]? {
        
        guard let jsonArray = jsonArray as? [[String: Any]] else { return nil }
        
        var rockets: [RocketInfo] = []
        
        for jsonObject in jsonArray {
            if let rocket = RocketInfo(json: jsonObject) {
                rockets.append(rocket)
            }
        }
        return rockets
    }
    
    enum CodingKeys: String, CodingKey {
        
        case flickrImages = "flickr_images"
        case name
        case firstFlight = "first_flight"
        case country
        case costPerLaunch = "cost_per_launch"
        case firstStage = "first_stage"
        case secondStage = "second_stage"
        case payloadWeights = "payload_weights"
    }
}
struct FirstStage: Hashable {
    var engines: Int
    var fuelAmountTons: Double
    var burnTimeSec: Int
    
    init(json: [String: Any]) {
        
        let engines = json["engines"] as? Int
        let fuelAmountTons = json["fuel_amount_tons"] as? Double
        let burnTimeSec = json["burn_time_sec"] as? Int
        
        self.fuelAmountTons = fuelAmountTons ?? 0
        self.engines = engines ?? 0
        self.burnTimeSec = burnTimeSec ?? 0
    }
    
    enum CodingKeys: String, CodingKey {
        
        case engines
        case fuelAmountTons = "fuel_amount_tons"
        case burnTimeSec = "burn_time_sec"
    }
}

struct SecondStage: Hashable {
    let engines: Int
    let fuelAmountTons: Double
    let burnTimeSec: Int
    
    init(json: [String: Any]) {
        let engines = json["engines"] as? Int
        let fuelAmountTons = json["fuel_amount_tons"] as? Double
        let burnTimeSec = json["burn_time_sec"] as? Int
        
        self.fuelAmountTons = fuelAmountTons ?? 0
        self.engines = engines ?? 0
        self.burnTimeSec = burnTimeSec ?? 0
    }
    enum CodingKeys: String, CodingKey {
        
        case engines
        case fuelAmountTons = "fuel_amount_tons"
        case burnTimeSec = "burn_time_sec"
    }
}

struct Height: Hashable {
    let meters: Double
    let feet: Double
    
    init(json: [String: Any]) {
        self.meters = json["meters"] as! Double
        self.feet = json["feet"] as! Double
    }
}

struct Diameter: Hashable {
    let meters: Double
    let feet: Double
    
    init(json: [String: Any]) {
        self.meters = json["meters"] as! Double
        self.feet = json["feet"] as! Double
    }
}

struct Mass: Hashable {
    let kg: Int
    let lb: Int
    var kgInt: Int {
        Int(kg)
    }
    var lbInt: Int {
        Int(lb)
    }
    
    init(json: [String: Any]) {
        self.kg = json["kg"] as! Int
        self.lb = json["lb"] as! Int
    }
}

struct PayloadWeight: Hashable {
    let kg: Int
    let lb: Int
    var kgInt: Int {
        Int(kg)
    }
    var lbInt: Int {
        Int(lb)
    }
    
    init?(data: [String: Any]) {
        self.kg = data["kg"] as! Int
        self.lb = data["lb"] as! Int
    }
}

