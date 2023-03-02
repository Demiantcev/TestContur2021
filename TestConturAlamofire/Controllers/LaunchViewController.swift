//
//  LaunchTableViewController.swift
//  TestConturAlamofire
//
//  Created by Кирилл Демьянцев on 22.01.2023.
//

import UIKit
import Alamofire

class LaunchViewController: UIViewController {
    
    var launch: [LaunchInfo] = []
    var rocketId: String?
    var rocketName: String?
    
    let tableViewLaunch: UITableView = {
        var table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .black
        table.allowsSelection = false
        table.register(LaunchTableViewCell.self, forCellReuseIdentifier: LaunchTableViewCell.reuseId)
        return table
    }()
    
    let titleLabel: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        parseJsonLaunch()
        setupConstraint()
        setupNavigation()
        titleLabel.text = rocketName
        tableViewLaunch.delegate = self
        tableViewLaunch.dataSource = self
    }
    
    func setupConstraint() {
        view.addSubview(tableViewLaunch)
        
        NSLayoutConstraint.activate([
            tableViewLaunch.topAnchor.constraint(equalTo: view.topAnchor),
            tableViewLaunch.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableViewLaunch.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableViewLaunch.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupNavigation() {
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.hidesBarsOnSwipe = true
        navigationItem.setHidesBackButton(false, animated: true)
        navigationItem.titleView = titleLabel
    }
    
    func parseJsonLaunch() {
        AF.request("https://api.spacexdata.com/v4/launches").responseJSON { responce in
            switch responce.result {
            case .success(let value):
                
                guard let launchJson = LaunchInfo.getArray(from: value) else { return }
                
                for element in launchJson {
                    if element.rocket == self.rocketId && self.rocketId != nil {
                        self.launch.append(element)
                    }
                }
                self.tableViewLaunch.reloadData()
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
extension LaunchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if launch.count > 1 {
            self.tableViewLaunch.restore()
        } else {
            self.tableViewLaunch.emptyLabel("Запусков не производилось!")
        }
        return launch.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LaunchTableViewCell.reuseId, for: indexPath) as! LaunchTableViewCell
        cell.configureCell(launch: launch, cell: cell, for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
}
