//
//  SettingsViewController.swift
//  TestConturAlamofire
//
//  Created by Кирилл Демьянцев on 05.02.2023.
//

import UIKit

class SettingsViewController: UIViewController {
    
    private var segmentedChange = false
    
    let titleLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Настройки"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    let heightLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Высота"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    lazy var heightSegmented: UISegmentedControl = {
        var segmented = UISegmentedControl(items: ["m", "ft"])
        segmented.translatesAutoresizingMaskIntoConstraints = false
        segmented.backgroundColor = #colorLiteral(red: 0.2077701986, green: 0.2103852332, blue: 0.2103391886, alpha: 1)
//        segmented.selectedSegmentIndex = 0
        segmented.addTarget(self, action: #selector(heightTarget), for: .valueChanged)
        return segmented
    }()
    
    @objc func heightTarget(_ sender: UISegmentedControl) {
        UserDefaults.standard.set(
            (sender.selectedSegmentIndex != 0)
            ? Params.m.rawValue
            : Params.ft.rawValue,
            forKey: Params.height.rawValue)
        segmentedChange = true
    }
    
    let diameterLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Диаметр"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    lazy var diameterSegmented: UISegmentedControl = {
        var segmented = UISegmentedControl(items: ["m", "ft"])
        segmented.translatesAutoresizingMaskIntoConstraints = false
        segmented.backgroundColor = #colorLiteral(red: 0.2077701986, green: 0.2103852332, blue: 0.2103391886, alpha: 1)
//        segmented.selectedSegmentIndex = 0
        segmented.addTarget(self, action: #selector(diameterTarget), for: .valueChanged)
        return segmented
    }()
    
    @objc func diameterTarget(_ sender: UISegmentedControl) {
        UserDefaults.standard.set(
            (sender.selectedSegmentIndex != 0)
            ? Params.m.rawValue
            : Params.ft.rawValue,
            forKey: Params.diameter.rawValue)
        segmentedChange = true
    }
    
    let massLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Масса"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    lazy var massSegmented: UISegmentedControl = {
        var segmented = UISegmentedControl(items: ["kg", "lb"])
        segmented.translatesAutoresizingMaskIntoConstraints = false
        segmented.backgroundColor = #colorLiteral(red: 0.2077701986, green: 0.2103852332, blue: 0.2103391886, alpha: 1)
//        segmented.selectedSegmentIndex = 0
        segmented.addTarget(self, action: #selector(massTarget), for: .valueChanged)
        return segmented
    }()
    
    @objc func massTarget(_ sender: UISegmentedControl) {
        UserDefaults.standard.set(
            (sender.selectedSegmentIndex != 0)
            ? Params.kg.rawValue
            : Params.lb.rawValue,
            forKey: Params.mass.rawValue)
        segmentedChange = true
    }
    
    let payloadWeightLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Полезная нагрузка"
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    lazy var payloadWeightSegmented: UISegmentedControl = {
        var segmented = UISegmentedControl(items: ["kg", "lb"])
        segmented.translatesAutoresizingMaskIntoConstraints = false
        segmented.backgroundColor = #colorLiteral(red: 0.2077701986, green: 0.2103852332, blue: 0.2103391886, alpha: 1)
//        segmented.selectedSegmentIndex = 0
        segmented.addTarget(self, action: #selector(payLoadTarget), for: .valueChanged)
        return segmented
    }()
    
    @objc func payLoadTarget(_ sender: UISegmentedControl) {
        UserDefaults.standard.set(
            (sender.selectedSegmentIndex != 0)
            ? Params.kg.rawValue
            : Params.lb.rawValue,
            forKey: Params.payWeight.rawValue)
        segmentedChange = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupConstraint()
        setupSegmentState()
        view.backgroundColor = .black
    }
    
    private func setupSegmentState() {
        UserDefaults.standard.string(forKey: Params.height.rawValue) == Params.m.rawValue
        ? (heightSegmented.selectedSegmentIndex = 1)
        : (heightSegmented.selectedSegmentIndex = 0)
        UserDefaults.standard.string(forKey: Params.diameter.rawValue) == Params.m.rawValue
        ? (diameterSegmented.selectedSegmentIndex = 1)
        : (diameterSegmented.selectedSegmentIndex = 0)
        UserDefaults.standard.string(forKey: Params.mass.rawValue) == Params.kg.rawValue
        ? (massSegmented.selectedSegmentIndex = 1)
        : (massSegmented.selectedSegmentIndex = 0)
        UserDefaults.standard.string(forKey: Params.payWeight.rawValue) == Params.kg.rawValue
        ? (payloadWeightSegmented.selectedSegmentIndex = 1)
        : (payloadWeightSegmented.selectedSegmentIndex = 0)
    }
    
    func setupConstraint() {
        view.addSubview(titleLabel)
        view.addSubview(heightLabel)
        view.addSubview(diameterLabel)
        view.addSubview(massLabel)
        view.addSubview(payloadWeightLabel)
        view.addSubview(heightSegmented)
        view.addSubview(diameterSegmented)
        view.addSubview(massSegmented)
        view.addSubview(payloadWeightSegmented)
        
        NSLayoutConstraint.activate([
            
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            heightLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            heightLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            diameterLabel.topAnchor.constraint(equalTo: heightLabel.bottomAnchor, constant: 50),
            diameterLabel.leadingAnchor.constraint(equalTo: heightLabel.leadingAnchor),
            
            massLabel.topAnchor.constraint(equalTo: diameterLabel.bottomAnchor, constant: 50),
            massLabel.leadingAnchor.constraint(equalTo: heightLabel.leadingAnchor),
            
            payloadWeightLabel.topAnchor.constraint(equalTo: massLabel.bottomAnchor, constant: 50),
            payloadWeightLabel.leadingAnchor.constraint(equalTo: heightLabel.leadingAnchor),
            
            heightSegmented.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            heightSegmented.centerYAnchor.constraint(equalTo: heightLabel.centerYAnchor),
            heightSegmented.heightAnchor.constraint(equalToConstant: 40),
            heightSegmented.widthAnchor.constraint(equalToConstant: 140),
            
            diameterSegmented.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            diameterSegmented.centerYAnchor.constraint(equalTo: diameterLabel.centerYAnchor),
            diameterSegmented.heightAnchor.constraint(equalToConstant: 40),
            diameterSegmented.widthAnchor.constraint(equalToConstant: 140),
            
            massSegmented.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            massSegmented.centerYAnchor.constraint(equalTo: massLabel.centerYAnchor),
            massSegmented.heightAnchor.constraint(equalToConstant: 40),
            massSegmented.widthAnchor.constraint(equalToConstant: 140),
            
            payloadWeightSegmented.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            payloadWeightSegmented.centerYAnchor.constraint(equalTo: payloadWeightLabel.centerYAnchor),
            payloadWeightSegmented.heightAnchor.constraint(equalToConstant: 40),
            payloadWeightSegmented.widthAnchor.constraint(equalToConstant: 140)
        ])
    }
}
