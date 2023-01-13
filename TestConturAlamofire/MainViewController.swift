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
    
    var rockets: [RocketInfo] = []
    
    let scrollView: UIScrollView = {
        var scroll = UIScrollView()
        scroll.showsHorizontalScrollIndicator = false
//        scroll.backgroundColor = .red
//        scroll.translatesAutoresizingMaskIntoConstraints = false
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
        
        scrollView.delegate = self
//        let content: [UIView] = createSlides()
//        setupScrollSlideView(slides: content)
        pageControl.numberOfPages = rockets.count
        pageControl.currentPage = 0
        view.bringSubviewToFront(pageControl)

    }
    
    func setupConstraint() {

        view.addSubview(scrollView)
        view.addSubview(pageControl)
//        scrollView.addSubview(contentView)

        NSLayoutConstraint.activate([

//            contentView.topAnchor.constraint(equalTo: view.topAnchor),
//            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageControl.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pageControl.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pageControl.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            pageControl.heightAnchor.constraint(equalToConstant: 68),

            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            scrollView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
    }
    
//    func createSlides() -> [UIView] {
//
//        let content1 = ContentView()
//        content1.imageRocket.image = UIImage(named: "meri")
//        content1.nameLabel.text = "First"
//        let content2 = ContentView()
//        content2.imageRocket.image = UIImage(named: "1")
//        content2.nameLabel.text = "Second"
//        let content3 = ContentView()
//        content3.nameLabel.text = "Third"
//        content3.imageRocket.image = UIImage(named: "7")
//        return [content1, content2, content3]
//    }
                        
    func setupScrollSlideView(slides: [UIView]) {
        scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(slides.count), height: view.frame.height)
        scrollView.isPagingEnabled = true
        for i in 0..<slides.count {
//            var page = UIImageView(frame: CGRect(x: CGFloat(i) * view.frame.size.width, y: 0, width: view.frame.size.width, height: scrollView.frame.size.height))
//            let gg = ["1", "7", "meri"]
            slides[i].frame = CGRect(x: view.frame.width * CGFloat(slides.count) , y: 0, width: scrollView.frame.width, height: scrollView.frame.height)
//            page.image = UIImage(named: gg[i])
//
            scrollView.addSubview(slides[i])
        }
    }

    func parsJSON() {
        AF.request("https://api.spacexdata.com/v4/rockets").responseJSON { [self] responseJSON in
            switch responseJSON.result {
            case .success(let value):
                
                guard let rocket = RocketInfo.getArray(from: value) else { return }
                
                self.rockets = rocket
//                createSetup()
//                let content: [UIView] = createSetup()
//                setupScrollSlideView(slides: content)
                
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
//    func createSetup() -> [UIView] {
//        
//        let content1 = ContentView()
//
//        for rocket in rockets {
//            
//            content1.nameLabel.text = rocket.name
//            content1.infoFirstFlightLabel.text = setDateFormat(date: rocket.firstFlight)
//            content1.infoCountryLabel.text = rocket.country
//            content1.infoCostPerLaunchLabel.text = "\(rocket.costPerLaunch)"
//            content1.enginesLabel2.text = "\(rocket.firstStage.engines)"
//            content1.fuelAmountTonsLabel2.text = "\(rocket.firstStage.fuelAmountTons) ton"
//            content1.burnTimeSecLabel2.text = "\(rocket.firstStage.burnTimeSec) sec"
//            content1.secondEnginesLabel.text = "\(rocket.secondStage.engines)"
//            content1.secondFuelAmountTonsLabel.text = "\(rocket.secondStage.fuelAmountTons) ton"
//            content1.secondBurnTimeSecLabel.text = "\(rocket.secondStage.burnTimeSec) sec"
//            if let image = rocket.flickrImages.randomElement() {
//
//                DispatchQueue.global().async {
//                    guard let url = URL(string: image) else { return }
//                    if let data = try? Data(contentsOf: url) {
//                        if let image1 = UIImage(data: data) {
//                            DispatchQueue.main.async {
//                                content1.imageRocket.image = image1
//                            }
//                        }
//                    }
//                }
//            }
//            self.contentView.nameLabel.text = rocket.name
//            self.contentView.infoFirstFlightLabel.text = setDateFormat(date: rocket.firstFlight)
//            self.contentView.infoCountryLabel.text = rocket.country
//            self.contentView.infoCostPerLaunchLabel.text = "\(rocket.costPerLaunch)"
//            self.contentView.enginesLabel2.text = "\(rocket.firstStage.engines)"
//            self.contentView.fuelAmountTonsLabel2.text = "\(rocket.firstStage.fuelAmountTons) ton"
//            self.contentView.burnTimeSecLabel2.text = "\(rocket.firstStage.burnTimeSec) sec"
//            self.contentView.secondEnginesLabel.text = "\(rocket.secondStage.engines)"
//            self.contentView.secondFuelAmountTonsLabel.text = "\(rocket.secondStage.fuelAmountTons) ton"
//            self.contentView.secondBurnTimeSecLabel.text = "\(rocket.secondStage.burnTimeSec) sec"
//
//            if let image = rocket.flickrImages.randomElement() {
//
//                DispatchQueue.global().async {
//                    guard let url = URL(string: image) else { return }
//                    if let data = try? Data(contentsOf: url) {
//                        if let image1 = UIImage(data: data) {
//                            DispatchQueue.main.async {
//                                self.contentView.imageRocket.image = image1
//                                print(image)
//                            }
//                        }
//                    }
//                }
//            }
//            pageControl.numberOfPages = rockets.count
//        }
//        return [content1]
//    }
}
extension MainViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
        pageControl.currentPage = Int(pageIndex)
    }
}
