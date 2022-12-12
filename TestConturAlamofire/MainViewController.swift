//
//  MainViewController.swift
//  TestConturAlamofire
//
//  Created by Кирилл Демьянцев on 04.11.2022.
//

import UIKit
import Alamofire
import SwiftyJSON

class MainViewController: UIViewController {
    
    var contentView = ContentView()
    var ss: [RocketInfo] = []
    
    let scrollView: UIScrollView = {
        var scroll = UIScrollView()
        
        return scroll
    }()
    let pageControl: UIPageControl = {
        var pageControl = UIPageControl()
        
        pageControl.backgroundColor = .black
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraint()
        parsJSON()
        print(ss)
        pageControl.numberOfPages = self.ss.count
        
    }
    func setupConstraint() {
        
        view.addSubview(contentView)
        contentView.addSubview(pageControl)
        
        NSLayoutConstraint.activate([
            
            contentView.topAnchor.constraint(equalTo: view.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            pageControl.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            pageControl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            pageControl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            pageControl.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            pageControl.heightAnchor.constraint(equalToConstant: 68)
            
        ])
    }
    
    func parsJSON() {
        AF.request("https://api.spacexdata.com/v4/rockets").responseJSON { responseJSON in
            switch responseJSON.result {
            case .success(let value):
                let json = JSON(value)
                let arrayCount = json.arrayValue
                for itm in arrayCount {
                    
                    let p = RocketInfo(json: itm)
//                    print(p)
                    self.ss.append(p)
                    
                    setup(p)
                    
                    
                    
//                    if let image = json[0]["flickr_images"][0].string {
//                        guard let imageURL = URL(string: image) else {return}
//
//                        DispatchQueue.global().async { [weak self] in
//                            if let data = try? Data(contentsOf: imageURL) {
//                                if let image = UIImage(data: data) {
//                                    DispatchQueue.main.async {
//                                        self?.dd.imageRocket.image = image
//                                    }
//                                }
//                            }
//                        }
//                    }
//                    if let name = json[0]["name"].string {
//                        self.dd.nameLabel.text = name
//                    }
//                    if let height = json[0]["height"]["meters"].double {
//                        print(height)
//                    }
//                    if let diameter = json[0]["diameter"]["meters"].double {
//                        print(diameter)
//                    }
//                    if let mass = json[0]["mass"]["kg"].int {
//                        print(mass)
//                    }
//                    let payloadWeights = json[0]["payload_weights"].arrayValue.map
//                    {$0["kg"].stringValue}
//                    print(payloadWeights)
//
//                    if let firstFlight = json[0]["first_flight"].string {
//                        self.dd.infoFirstFlightLabel.text = firstFlight
//                    }
//                    if let country = json[0]["country"].string {
//                        self.dd.infoCountryLabel.text = country
//                    }
//                    if let costPerLaunch = json[0]["cost_per_launch"].int {
//                        self.dd.infoCostPerLaunchLabel.text = "$\(costPerLaunch) млн "
//                    }
//                    if let firstStageEngines = json[0]["first_stage"]["engines"].int {
//                        self.dd.enginesLabel2.text = "\(firstStageEngines)"
//                    }
//                    if let firstStageFuelAmountTons = json[0]["first_stage"]["fuel_amount_tons"].double {
//                        self.dd.fuelAmountTonsLabel2.text = "\(firstStageFuelAmountTons) ton"
//                    }
//                    if let firstStageBurnTimeSec = json[0]["first_stage"]["burn_time_sec"].int {
//                        self.dd.burnTimeSecLabel2.text = "\(firstStageBurnTimeSec) sec"
//                    }
//                    if let secondStageEngines = json[0]["second_stage"]["engines"].int {
//                        self.dd.secondEnginesLabel.text = "\(secondStageEngines)"
//                    }
//                    if let secondStageFuelAmountTons = json[0]["second_stage"]["fuel_amount_tons"].double {
//                        self.dd.secondFuelAmountTonsLabel.text = "\(secondStageFuelAmountTons) ton"
//                    }
//                    if let secondStageBurnTimeSec = json[0]["second_stage"]["burn_time_sec"].int {
//                        self.dd.secondBurnTimeSecLabel.text = "\(secondStageBurnTimeSec) sec"
//                    }
                }
 
            case .failure(let error):
                print(error)
            }
            
            func setDateFormat(date: String) -> String {
               let dateForamatter = DateFormatter()
               dateForamatter.dateFormat = "yyyy'-'MM'-'dd"

                guard let backendDate = dateForamatter.date(from: date) else { return  ""}

                let formatDate = DateFormatter()
                formatDate.dateFormat = "dd-MM-yyyy"
                let date = formatDate.string(from: backendDate)
                return date
            }
            
            func setup(_ array: RocketInfo) {
                self.contentView.nameLabel.text = array.name
                if let image = array.flickrImages.randomElement() {
                    guard let url = URL(string: image) else { return }
                    DispatchQueue.global().async {
                        if let data = try? Data(contentsOf: url) {
                            if let image = UIImage(data: data) {
                                DispatchQueue.main.async {
                                    self.contentView.imageRocket.image = image
                                }
                            }
                        }
                    }
                }
                self.contentView.infoFirstFlightLabel.text = setDateFormat(date: array.firstFlight)
                self.contentView.infoCountryLabel.text = array.country
                self.contentView.infoCostPerLaunchLabel.text = "\(array.costPerLaunch)"
                self.contentView.enginesLabel2.text = "\(array.firstStage.engines)"
                self.contentView.fuelAmountTonsLabel2.text = "\(array.firstStage.fuelAmountTons) ton"
                self.contentView.burnTimeSecLabel2.text = "\(array.firstStage.burnTimeSec) sec"
                self.contentView.secondEnginesLabel.text = "\(array.secondStage.engines)"
                self.contentView.secondFuelAmountTonsLabel.text = "\(array.secondStage.fuelAmountTons) ton"
                self.contentView.secondBurnTimeSecLabel.text = "\(array.secondStage.burnTimeSec) sec"
                self.pageControl.numberOfPages = self.ss.count
            }
        }
    }
}
