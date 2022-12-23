//
//  Model.swift
//  TestConturAlamofire
//
//  Created by Кирилл Демьянцев on 27.10.2022.
//

import Foundation
import SwiftyJSON

struct RocketInfo {
    
//    let height: Height
//    let diameter: Diameter
//    let mass: Mass
//    let payloadWeights: PayloadWeight
    let flickrImages: [String]
    let name: String
    let firstFlight: String
    let country: String
    let costPerLaunch: Int
    let firstStage: FirstStage
    let secondStage: SecondStage
    
    init?(json: [String: Any]) {
//        self.flickrImages = json["flickr_images"] as! [String]
//        self.name = json["name"] as! String
//        self.firstFlight = json["first_flight"] as! String
//        self.country = json["country"] as! String
//        self.costPerLaunch = json["cost_per_launch"] as! Int
//        let ff = json["first_stage"] as! [String: Any]
//        self.firstStage = FirstStage(json: ff)
        guard
            let flickrImages = json["flickr_images"] as? [String],
            let name = json["name"] as? String,
            let firstFlight = json["first_flight"] as? String,
            let country = json["country"] as? String,
            let costPerLaunch = json["cost_per_launch"] as? Int,
            let firstStageJson = json["first_stage"] as? [String: Any],
            let secondStageJson = json["first_stage"] as? [String: Any]
        else {
            return nil
        }
        self.flickrImages = flickrImages
        self.name = name
        self.firstFlight = firstFlight
        self.country = country
        self.costPerLaunch = costPerLaunch
        self.firstStage = FirstStage(json: firstStageJson)
        self.secondStage = SecondStage(json: secondStageJson)
//        self.firstStage = FirstStage(json: firstStageJson)
//        let secondStageJson = json["second_stage"] as! [String: Any]
//        self.secondStage = SecondStage(json: secondStageJson)
//        let heightJson = json["height"] as! [String: Any]
//        self.height = Height(json: heightJson)
//        let massJson = json["mass"] as! [String: Any]
//        self.mass = Mass(json: massJson)
//        let diameterJson = json["diameter"] as! [String: Any]
//        self.diameter = Diameter(json: diameterJson)
//        let payloadWeights = json["payload_weights"] as! [String: Any]
//        self.payloadWeights = PayloadWeight(json: payloadWeights)
    }
//    init(json: JSON) {
//        self.flickrImages = json["flickr_images"].arrayValue.map{$0[].stringValue}
//        self.name = json["name"].stringValue
//        self.firstFlight = json["first_flight"].stringValue
//        self.country = json["country"].stringValue
//        self.costPerLaunch = json["cost_per_launch"].intValue
//        self.firstStage = FirstStage(json: json["first_stage"])
//        self.secondStage = SecondStage(json: json["second_stage"])
//        self.height = Height(json: json["height"])
//        self.mass = Mass(json: json["mass"])
//        self.diameter = Diameter(json: json["diameter"])
//        self.payloadWeights = PayloadWeight(json: json["payload_weights"])
//    }
    
    static func getArray(from jsonArray: Any) -> [RocketInfo]? {
        
        guard let jsonArray = jsonArray as? [[String: Any]] else { return nil }
        
        var rockets: [RocketInfo] = []
        
        for jsonObject in jsonArray {
            guard let rocket = RocketInfo(json: jsonObject)
            else {
                return nil
            }
            rockets.append(rocket)
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
//        case payloadWeights = "payload_weights"
    }
}
struct FirstStage {
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
//    init(json: JSON) {
//        self.engines = json["engines"].intValue
//        self.fuelAmountTons = json["fuel_amount_tons"].doubleValue
//        self.burnTimeSec = json["burn_time_sec"].intValue
//    }
    
    enum CodingKeys: String, CodingKey {
        
        case engines
        case fuelAmountTons = "fuel_amount_tons"
        case burnTimeSec = "burn_time_sec"
    }
}

struct SecondStage {
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
//    init(json: JSON) {
//        self.engines = json["engines"].intValue
//        self.fuelAmountTons = json["fuel_amount_tons"].doubleValue
//        self.burnTimeSec = json["burn_time_sec"].intValue
//    }
    
    enum CodingKeys: String, CodingKey {
        
        case engines
        case fuelAmountTons = "fuel_amount_tons"
        case burnTimeSec = "burn_time_sec"
    }
}

struct СharacteristicForCells {
    
    let height: Height
    let diameter: Diameter
    let mass: Mass
//    let payloadWeights: [PayloadWeight]
    
    init    (json: [String: Any]) {
        let heightJson = json["height"] as! [String: Any]
        self.height = Height(json: heightJson)
        let diameterJson = json["diameter"] as! [String: Any]
        self.diameter = Diameter(json: diameterJson)
        let massJson = json["mass"] as! [String: Any]
        self.mass = Mass(json: massJson)
//        let payloadWeightsJson = json["payload_weights"] as! [String: Any]
//        self.payloadWeights = PayloadWeight(json: payloadWeightsJson)

    }
    
    init(json: JSON) {
        self.height = Height(json: json["height"])
        self.diameter = Diameter(json: json["diameter"])
        self.mass = Mass(json: json["mass"])
//        self.payloadWeights = PayloadWeight(json: json["payload_weights"].arrayValue)
    }
    
    enum CodingKeys: String, CodingKey {
        case height
        case diameter
        case mass
        case payloadWeights = "payload_weights"
    }
}

struct Height {
    let meters: Double
    let feet: Double
    
    init(json: [String: Any]) {
        self.meters = json["meters"] as! Double
        self.feet = json["feet"] as! Double
    }
    init(json: JSON) {
        self.meters = json["meters"].doubleValue
        self.feet = json["feet"].doubleValue
    }
}

struct Diameter {
    let meters: Double
    let feet: Double
    
    init(json: [String: Any]) {
        self.meters = json["meters"] as! Double
        self.feet = json["feet"] as! Double
    }
    init(json: JSON) {
        self.meters = json["meters"].doubleValue
        self.feet = json["feet"].doubleValue
    }
}

struct Mass {
    let kg: Double
    let lb: Double
    
    init(json: [String: Any]) {
        self.kg = json["kg"] as! Double
        self.lb = json["lb"] as! Double
    }
    init(json: JSON) {
        self.kg = json["kg"].doubleValue
        self.lb = json["lb"].doubleValue
    }
}

struct PayloadWeight {
    let kg: Int
    let lb: Int
    
    init(json: [String: Any]) {
        self.kg = json["kg"] as! Int
        self.lb = json["lb"] as! Int
    }
    init(json: JSON) {
        self.kg = json["kg"].intValue
        self.lb = json["lb"].intValue
    }
}
