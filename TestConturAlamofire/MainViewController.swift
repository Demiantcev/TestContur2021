//
//  MainViewController.swift
//  TestConturAlamofire
//
//  Created by Кирилл Демьянцев on 04.11.2022.
//

import UIKit
import Alamofire
import SwiftyJSON
import AlamofireImage

class MainViewController: UIViewController {
    
    var contentView = ContentView()
    var rockets: [RocketInfo] = []
    var content: [ContentView] = []
    
    
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
    
    func setupScroll(slide: [ContentView]) {
        
    }
    
    func parsJSON() {
        AF.request("https://api.spacexdata.com/v4/rockets").responseJSON { [self] responseJSON in
            switch responseJSON.result {
            case .success(let value):
                
                guard let rocket = RocketInfo.getArray(from: value) else { return }
                
                self.rockets = rocket
                createSetup()
                
            case .failure(let error):
                print(error)
            }
        }
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
    
    func createSetup() {

        for i in rockets {
            
            self.contentView.nameLabel.text = i.name
            self.contentView.infoFirstFlightLabel.text = setDateFormat(date: i.firstFlight)
            self.contentView.infoCountryLabel.text = i.country
            self.contentView.infoCostPerLaunchLabel.text = "\(i.costPerLaunch)"
            self.contentView.enginesLabel2.text = "\(i.firstStage.engines)"
            self.contentView.fuelAmountTonsLabel2.text = "\(i.firstStage.fuelAmountTons) ton"
            self.contentView.burnTimeSecLabel2.text = "\(i.firstStage.burnTimeSec) sec"
            self.contentView.secondEnginesLabel.text = "\(i.secondStage.engines)"
            self.contentView.secondFuelAmountTonsLabel.text = "\(i.secondStage.fuelAmountTons) ton"
            self.contentView.secondBurnTimeSecLabel.text = "\(i.secondStage.burnTimeSec) sec"
            
            if let image = i.flickrImages.randomElement() {

                DispatchQueue.global().async {
                    guard let url = URL(string: image) else { return }
                    if let data = try? Data(contentsOf: url) {
                        if let image1 = UIImage(data: data) {
                            DispatchQueue.main.async {
                                self.contentView.imageRocket.image = image1
                                print(image)
                            }
                        }
                    }
                }
            }
        }
    }
//    func parsImage() {
//        for i in rockets {
//            let d = i.flickrImages.randomElement()
//            AF.request(d!).responseImage { response in
//                if let image = response.value {
//                    DispatchQueue.main.async {
//                        self.contentView.imageRocket.image = image
//                    }
//                }
//            }
//        }
//    }
}
