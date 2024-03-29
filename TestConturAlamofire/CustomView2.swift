//
//  CustomView2.swift
//  TestConturAlamofire
//
//  Created by Кирилл Демьянцев on 08.01.2023.
//

import UIKit

class ContentView2: UIView {
    
    let collectionCell = HorizontalCell()
    
    let viewS: UIView = {
        var view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 40
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        return view
    }()
    
    let nameLabel: UILabel = {
       var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Name"
        label.font = .systemFont(ofSize: 25, weight: .bold)
        label.textColor = .white
//        label.font = UIFont(name: "AvenirNext-Bold", size: 25)
        return label
    }()
    
    let imageRocket: UIImageView = {
        var image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .top
//        image.image = UIImage(named: "meri")
        return image
    }()
    
    let scrollContent: UIScrollView = {
       var scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.bounces = true
        scroll.showsVerticalScrollIndicator = false
        return scroll
    }()
    
     let firstStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    let firstFlightLabel: UILabel = {
       var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Первый запуск"
        label.textColor = .white
        return label
    }()
    
    let countryLabel: UILabel = {
       var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Страна"
        label.textColor = .white
        return label
    }()
    
    let costPerLaunchLabel: UILabel = {
       var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Стоимость запуска"
        label.textColor = .white
        return label
    }()
    
    let secondStackView: UIStackView = {
       let stackView = UIStackView()
       stackView.translatesAutoresizingMaskIntoConstraints = false
       stackView.axis = .vertical
       stackView.spacing = 16
       stackView.distribution = .equalSpacing
       return stackView
   }()
    
    let infoFirstFlightLabel: UILabel = {
       var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "nil"
        label.textColor = .white
        return label
    }()
    
    let infoCountryLabel: UILabel = {
       var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "nil"
        label.numberOfLines = 0
        label.textColor = .white
        return label
    }()
    
    let infoCostPerLaunchLabel: UILabel = {
       var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "nil"
        label.textColor = .white
        return label
    }()
    
    let firstStageLabel: UILabel = {
       var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Первая ступень"
        label.font = .systemFont(ofSize: 23, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    let thirdStackView: UIStackView = {
       let stackView = UIStackView()
       stackView.translatesAutoresizingMaskIntoConstraints = false
       stackView.axis = .vertical
       stackView.spacing = 16
       stackView.distribution = .fillEqually
       return stackView
   }()
    
    let firstStageEnginesLabel: UILabel = {
       var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Количество двигателей"
        label.textColor = .white
        return label
    }()
    
    let firstStageFuelAmountTonsLabel: UILabel = {
       var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Количество топлива"
        label.textColor = .white
        return label
    }()
    
    let firstStageBurnTimeSecLabel: UILabel = {
       var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Время сгорания"
        label.textColor = .white
        return label
    }()
    
    let fourthStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    let enginesLabel2: UILabel = {
       var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "nil"
        label.textColor = .white
        return label
    }()
    
    let fuelAmountTonsLabel2: UILabel = {
       var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "nil"
        label.textColor = .white
        return label
    }()
    
    let burnTimeSecLabel2: UILabel = {
       var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "nil"
        label.textColor = .white
        return label
    }()
    
    let secondStageLabel: UILabel = {
       var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Вторая ступень"
        label.font = .systemFont(ofSize: 23, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    let fiveStackView: UIStackView = {
       let stackView = UIStackView()
       stackView.translatesAutoresizingMaskIntoConstraints = false
       stackView.axis = .vertical
       stackView.spacing = 16
       stackView.distribution = .fillEqually
       return stackView
   }()
    
    let secondStageEnginesLabel: UILabel = {
       var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Количество двигателей"
        label.textColor = .white
        return label
    }()
    
    let secondStageFuelAmountTonsLabel: UILabel = {
       var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Количество топлива"
        label.textColor = .white
        return label
    }()
    
    let secondStageBurnTimeSecLabel: UILabel = {
       var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Время сгорания"
        label.textColor = .white
        return label
    }()
    
    let sixStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    let secondEnginesLabel: UILabel = {
       var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "nil"
        label.textColor = .white
        return label
    }()
    
    let secondFuelAmountTonsLabel: UILabel = {
       var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "nil"
        label.textColor = .white
        return label
    }()
    
    let secondBurnTimeSecLabel: UILabel = {
       var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "nil"
        label.textColor = .white
        return label
    }()
    
    lazy var launchButton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Посмотреть запуски", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .gray
        button.layer.cornerRadius = 20
        button.titleLabel?.font = UIFont(name: "AvenirNext-Bold", size: 18)
        button.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        return button
    }()
    
    @objc func tapButton() {
        print("hello")
    }
    
    lazy var setupButton: UIButton = {
        var button = UIButton()
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 20, weight: .medium, scale: .large)
        let largeBoldDoc = UIImage(systemName: "gearshape", withConfiguration: largeConfig)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(largeBoldDoc, for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraint() {
        
        self.addSubview(scrollContent)
        scrollContent.addSubview(imageRocket)
        scrollContent.addSubview(viewS)
        viewS.addSubview(nameLabel)
        viewS.addSubview(collectionCell)
        viewS.addSubview(firstStackView)
        viewS.addSubview(secondStackView)
        viewS.addSubview(launchButton)
        viewS.addSubview(setupButton)
        firstStackView.addArrangedSubview(firstFlightLabel)
        firstStackView.addArrangedSubview(countryLabel)
        firstStackView.addArrangedSubview(costPerLaunchLabel)
        secondStackView.addArrangedSubview(infoFirstFlightLabel)
        secondStackView.addArrangedSubview(infoCountryLabel)
        secondStackView.addArrangedSubview(infoCostPerLaunchLabel)
        viewS.addSubview(firstStageLabel)
        viewS.addSubview(thirdStackView)
        thirdStackView.addArrangedSubview(firstStageEnginesLabel)
        thirdStackView.addArrangedSubview(firstStageFuelAmountTonsLabel)
        thirdStackView.addArrangedSubview(firstStageBurnTimeSecLabel)
        viewS.addSubview(fourthStackView)
        fourthStackView.addArrangedSubview(enginesLabel2)
        fourthStackView.addArrangedSubview(fuelAmountTonsLabel2)
        fourthStackView.addArrangedSubview(burnTimeSecLabel2)
        viewS.addSubview(secondStageLabel)
        viewS.addSubview(fiveStackView)
        fiveStackView.addArrangedSubview(secondStageEnginesLabel)
        fiveStackView.addArrangedSubview(secondStageFuelAmountTonsLabel)
        fiveStackView.addArrangedSubview(secondStageBurnTimeSecLabel)
        viewS.addSubview(sixStackView)
        sixStackView.addArrangedSubview(secondEnginesLabel)
        sixStackView.addArrangedSubview(secondFuelAmountTonsLabel)
        sixStackView.addArrangedSubview(secondBurnTimeSecLabel)
        
        NSLayoutConstraint.activate([
            
            scrollContent.topAnchor.constraint(equalTo: self.topAnchor),
            scrollContent.widthAnchor.constraint(equalTo: self.widthAnchor),
            scrollContent.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollContent.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            scrollContent.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            imageRocket.centerXAnchor.constraint(equalTo: scrollContent.centerXAnchor),
            imageRocket.topAnchor.constraint(equalTo: scrollContent.topAnchor),
            imageRocket.trailingAnchor.constraint(equalTo: scrollContent.trailingAnchor),
            imageRocket.leadingAnchor.constraint(equalTo: scrollContent.leadingAnchor),
            
            viewS.topAnchor.constraint(equalTo: scrollContent.centerYAnchor),
            viewS.heightAnchor.constraint(equalTo: scrollContent.heightAnchor),
            viewS.leadingAnchor.constraint(equalTo: scrollContent.leadingAnchor),
            viewS.trailingAnchor.constraint(equalTo: scrollContent.trailingAnchor),
            viewS.bottomAnchor.constraint(equalTo: scrollContent.bottomAnchor),
            viewS.widthAnchor.constraint(equalTo: scrollContent.widthAnchor),
       
            nameLabel.topAnchor.constraint(equalTo: viewS.topAnchor, constant: 48),
            nameLabel.leadingAnchor.constraint(equalTo: viewS.leadingAnchor, constant: 32),
            
            collectionCell.topAnchor.constraint(equalTo: viewS.topAnchor, constant: 112),
            collectionCell.leadingAnchor.constraint(equalTo: viewS.leadingAnchor),
            collectionCell.trailingAnchor.constraint(equalTo: viewS.trailingAnchor),
            collectionCell.heightAnchor.constraint(equalToConstant: 96),
            
            firstStackView.topAnchor.constraint(equalTo: collectionCell.bottomAnchor, constant: 40),
            firstStackView.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            firstStackView.trailingAnchor.constraint(equalTo: viewS.trailingAnchor, constant: -167),
            
            secondStackView.topAnchor.constraint(equalTo: firstStackView.topAnchor),
            secondStackView.trailingAnchor.constraint(equalTo: viewS.trailingAnchor),
            secondStackView.leadingAnchor.constraint(equalTo: firstStackView.trailingAnchor, constant: 80),
            secondStackView.bottomAnchor.constraint(equalTo: firstStageLabel.topAnchor, constant: -40),
            
            firstStageLabel.topAnchor.constraint(equalTo: firstStackView.bottomAnchor, constant: 40),
            firstStageLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            
            thirdStackView.topAnchor.constraint(equalTo: firstStageLabel.bottomAnchor, constant: 16),
//            thirdStackView.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            thirdStackView.trailingAnchor.constraint(equalTo: viewS.trailingAnchor, constant: -167),
            
            fourthStackView.topAnchor.constraint(equalTo: thirdStackView.topAnchor),
            fourthStackView.trailingAnchor.constraint(equalTo: viewS.trailingAnchor, constant: -68),
            
            secondStageLabel.topAnchor.constraint(equalTo: thirdStackView.bottomAnchor, constant: 40),
            secondStageLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            
            fiveStackView.topAnchor.constraint(equalTo: secondStageLabel.bottomAnchor, constant: 16),
            fiveStackView.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            
            sixStackView.topAnchor.constraint(equalTo: fiveStackView.topAnchor),
            sixStackView.trailingAnchor.constraint(equalTo: viewS.trailingAnchor, constant: -68),
            
            launchButton.topAnchor.constraint(equalTo: fiveStackView.bottomAnchor, constant: 40),
            launchButton.leadingAnchor.constraint(equalTo: viewS.leadingAnchor, constant: 32),
            launchButton.trailingAnchor.constraint(equalTo: viewS.trailingAnchor, constant: -32),
            launchButton.heightAnchor.constraint(equalToConstant: 55),
            
            setupButton.topAnchor.constraint(equalTo: viewS.topAnchor, constant: 50.67),
            setupButton.trailingAnchor.constraint(equalTo: viewS.trailingAnchor, constant: -35.62),
            
        ])
    }
}
