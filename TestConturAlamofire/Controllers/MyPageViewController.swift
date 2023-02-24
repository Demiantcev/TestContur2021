//
//  MyPageViewController.swift
//  TestConturAlamofire
//
//  Created by Кирилл Демьянцев on 09.01.2023.
//

import UIKit
import Alamofire

class MyPageViewController: UIPageViewController {
    
    var myRocket = [UIViewController]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backItem = UIBarButtonItem()
        backItem.title = "Назад"
        navigationItem.backBarButtonItem = backItem
        navigationItem.backBarButtonItem?.tintColor = .white
        self.dataSource = self
        self.delegate = self
        
        myRocket = [
            DetailViewController.getInstance(index: 0),
            DetailViewController.getInstance(index: 1),
            DetailViewController.getInstance(index: 2),
            DetailViewController.getInstance(index: 3)
        ]

        setViewControllers([myRocket[0]], direction: .forward, animated: true)
    }
    
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: navigationOrientation, options: nil)
        self.view.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension MyPageViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewController = viewController as? DetailViewController else { return nil }
        if let index = myRocket.firstIndex(of: viewController) {
            if index > 0 {
                return myRocket[index - 1]
            }
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewController = viewController as? DetailViewController else { return nil }
        if let index = myRocket.firstIndex(of: viewController) {
            if index < myRocket.count - 1 {
                return myRocket[index + 1]
            }
        }
        return nil
    }
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        
        return myRocket.count
    }
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
}
