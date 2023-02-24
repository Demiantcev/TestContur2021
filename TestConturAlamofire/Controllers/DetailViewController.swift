//
//  DetailViewController.swift
//  TestConturAlamofire
//
//  Created by Кирилл Демьянцев on 29.01.2023.
//

import UIKit
import Alamofire

class DetailViewController: UIViewController, PresentLaunchVC, PresentSettingVC {
    
    private let networkAPI = NetworkAPI.shared
    private var rockets: [RocketInfo] = []
    private var index: Int = 0
    private var dataSource: UICollectionViewDiffableDataSource<SectionType, Cell>! = nil
    private var collectionView: UICollectionView! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        createDataSource()
        reload()
                NotificationCenter.default.addObserver(
                    self,
                    selector: #selector(reload),
                    name: Notification.Name("reloadData"),
                    object: nil
                )
    }
        @objc
        private func reload() {
            AF.request("https://api.spacexdata.com/v4/rockets").responseJSON { [self] responseJSON in
                switch responseJSON.result {
                case .success(let value):

                    guard let rocket = RocketInfo.getArray(from: value) else { return }
                    self.rockets = rocket
                    
                    self.reloadData()
                case .failure(let error):
                    print(error)
                }
            }
        }
    
    static func getInstance(index: Int) -> DetailViewController {
        let page = DetailViewController()
        page.index = index
        return page
    }
    
    func presentLaunch() {
        let launchViewController = LaunchViewController()
        launchViewController.rocketId = rockets[self.index].id
        launchViewController.rocketName = rockets[self.index].name
        navigationController?.pushViewController(launchViewController, animated: true)
    }
    
    func presentSetting() {
        let settingViewController = SettingsViewController()
        self.present(settingViewController, animated: true)
    }
    
    private func setupCollectionView() {
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .black
        
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: ImageCell.reuseId)
        collectionView.register(HorizontalViewCell.self, forCellWithReuseIdentifier: HorizontalViewCell.reuseId)
        collectionView.register(VerticalCell.self, forCellWithReuseIdentifier: VerticalCell.reuseId)
        collectionView.register(ButtonCell.self, forCellWithReuseIdentifier: ButtonCell.reuseId)
        collectionView.register(
            StageHeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,withReuseIdentifier: StageHeaderCell.reuseId
        )
        view.addSubview(collectionView)
    }
    
    func section(rocket: RocketInfo) -> [Section] {
        [
            Section(type: .imageSection, cells:
                        [Cell(title: "Image", value: rocket.name)]),
            Section(
                type: .horizontalSection,
                cells: [
                    UserDefaults.standard.string(forKey: Params.height.rawValue) == Params.m.rawValue
                    ? Cell(title: "Высота, ft", value: String(rocket.height.feet))
                    : Cell(title: "Высота, m", value: String(rocket.height.meters)),
                    UserDefaults.standard.string(forKey: Params.diameter.rawValue) == Params.m.rawValue
                    ? Cell(title: "Диаметр, ft", value: String(rocket.diameter.feet))
                    : Cell(title: "Диаметр, m", value: String(rocket.diameter.meters)),
                    UserDefaults.standard.string(forKey: Params.mass.rawValue) == Params.kg.rawValue
                    ? Cell(title: "Масса, lb", value: String(rocket.mass.lbInt))
                    : Cell(title: "Масса, kg", value: String(rocket.mass.kgInt)),
                    UserDefaults.standard.string(forKey: Params.payWeight.rawValue) == Params.kg.rawValue
                    ? Cell(title: "Нагрузка, lb", value: String(rocket.payloadWeights[0].lbInt))
                    : Cell(title: "Нагрузка, kg", value: String(rocket.payloadWeights[0].kgInt))
                ]
            ),
            Section(type: .mainSection, cells: [
                Cell(title: "Первый запуск", value: rocket.firstFlightFormatter),
                Cell(title: "Страна", value: rocket.countryString),
                Cell(title: "Стоимость запуска", value: rocket.launchCost)
            ]),
            Section(type: .firstStageSection, cells: [
                Cell(title: "Количество двигателей", value: String(rocket.firstStage.engines)),
                Cell(title: "Количество топлива", value: "\(rocket.firstStage.fuelAmountTons) ton"),
                Cell(title: "Время сгорания", value: "\(rocket.firstStage.burnTimeSec) sec")
            ]),
            Section(type: .secondStageSection, cells: [
                Cell(title: "Количество двигателей", value: String(rocket.secondStage.engines)),
                Cell(title: "Количество топлива", value: "\(rocket.secondStage.fuelAmountTons) ton"),
                Cell(title: "Время сгорания", value: "\(rocket.secondStage.burnTimeSec) sec")
            ]),
            Section(type: .launchesButtonSection, cells: [Cell(title: "Запуски", value: rocket.id)])
        ]
    }
    // MARK: - createDataSource
    
    private func createDataSource() {
        dataSource = .init(collectionView: collectionView ) { collectionView, indexPath, model in
            let section = SectionType(rawValue: indexPath.section) ?? .mainSection
            switch section {
            case .imageSection:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCell.reuseId, for: indexPath) as? ImageCell else { return UICollectionViewCell()
                }
                self.networkAPI.image(post: self.rockets[self.index]) { data, _ in
                    DispatchQueue.main.async {
                        let img = self.networkAPI.image(data: data)
                        cell.image = img
                    }
                }
                cell.configure(with: model)
                cell.cellDelegate = self
                return cell
            case .horizontalSection:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HorizontalViewCell.reuseId, for: indexPath) as? HorizontalViewCell else { return UICollectionViewCell() }
                cell.configure(with: model)
                return cell
            case .mainSection:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VerticalCell.reuseId, for: indexPath) as? VerticalCell else { return UICollectionViewCell() }
                cell.configure(with: model)
                return cell
            case .firstStageSection:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VerticalCell.reuseId, for: indexPath) as? VerticalCell else { return UICollectionViewCell() }
                cell.configure(with: model)
                return cell
            case .secondStageSection:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VerticalCell.reuseId, for: indexPath) as? VerticalCell else { return UICollectionViewCell() }
                cell.configure(with: model)
                return cell
            case .launchesButtonSection:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ButtonCell.reuseId, for: indexPath) as? ButtonCell else { return UICollectionViewCell() }
                cell.delegate = self
                return cell
            }
        }
        dataSource.supplementaryViewProvider = { [unowned self] collectionView, kind, indexPath in
            self.supplementary(collectionView: collectionView, kind: kind, indexPath: indexPath)
        }
    }
    private func supplementary(collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView? {
        guard let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: StageHeaderCell.reuseId,
            for: indexPath
        ) as? StageHeaderCell else {
            return UICollectionReusableView()
        }
        if indexPath.section == 3 {
            header.configure(with: "Пeрвая ступень")
        } else {
            header.configure(with: "Вторая ступень")
        }
        return header
    }
    
    func reloadData() {
        var snapshot = NSDiffableDataSourceSnapshot<SectionType, Cell>()
        let rocket = rockets[index]
        let sections = section(rocket: rocket)
        sections.forEach { section in
            snapshot.appendSections([section.type])
            snapshot.appendItems(section.cells, toSection: section.type)
        }
        dataSource?.apply(snapshot)
    }
}
