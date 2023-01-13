//
//  MyPageViewController.swift
//  TestConturAlamofire
//
//  Created by Кирилл Демьянцев on 09.01.2023.
//

import UIKit
import Alamofire

class MyPageViewController: UIPageViewController {
    
    var rockets = [RocketInfo]()
    
    var myRocket = [MyViewController]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        parsJSON()
    }
    
    func parsJSON() {
        AF.request("https://api.spacexdata.com/v4/rockets").responseJSON { [self] responseJSON in
            switch responseJSON.result {
            case .success(let value):

                guard let rocket = RocketInfo.getArray(from: value) else { return }
                self.rockets = rocket
    
                self.myRocket = arrayViewController()
                setViewControllers([myRocket[0]], direction: .forward, animated: true, completion: nil)

            case .failure(let error):
                print(error)
            }
        }
    }
    
    func arrayViewController() -> [MyViewController] {
        var rocketDD = [MyViewController]()
        for rock in rockets {
            rocketDD.append(MyViewController(rocketWith: rock))
        }
        return rocketDD
    }
    
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: navigationOrientation, options: nil)
        self.view.backgroundColor = .clear
        self.dataSource = self
        self.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension MyPageViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewController = viewController as? MyViewController else { return nil }
        if let index = myRocket.index(of: viewController) {
            if index > 0 {
                return myRocket[index - 1]
            }
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewController = viewController as? MyViewController else { return nil }
        if let index = myRocket.index(of: viewController) {
            if index < rockets.count - 1 {
                return myRocket[index + 1]
            }
        }
        return nil
    }
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        
        return rockets.count
    }
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
}
