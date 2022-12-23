//
//  HorizontalCell.swift
//  TestConturAlamofire
//
//  Created by Кирилл Демьянцев on 06.11.2022.
//

import UIKit
import Alamofire
import SwiftyJSON

protocol SelectCollectionViewItemProtocol: AnyObject {
    func selectItem(index: IndexPath)
}

class HorizontalCell: UICollectionView {
    
    private let paramLayout = UICollectionViewFlowLayout()
    private let nameParamArray = ["Высота,m", "Диаметр,m", "Масса,kg", "Нагрузка,kg"]
    var characteristicsArray: [Any] = []
    var ff: [СharacteristicForCells] = []
    
    weak var cellDelegate: SelectCollectionViewItemProtocol?
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: .zero, collectionViewLayout: paramLayout)
        configure()
        parsJSONCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        
        paramLayout.minimumLineSpacing = 12
        paramLayout.scrollDirection = .horizontal
        
        backgroundColor = .none
        translatesAutoresizingMaskIntoConstraints = false
        bounces = true
        showsHorizontalScrollIndicator = false
        
        delegate = self
        dataSource = self
        register(HorizintalViewCell.self, forCellWithReuseIdentifier: "cell")
    }
    
    private func parsJSONCollectionView() {
        AF.request("https://api.spacexdata.com/v4/rockets").responseJSON { responseJSON in
            switch responseJSON.result {
            case .success(let value):

//                for (_, data) in json {
//                    let kg = data["payload_weights"].arrayValue.map{$0["kg"].intValue}
//                    let param = [data["height", "meters"].doubleValue, data["diameter","meters"].doubleValue, data["mass", "kg"].intValue, data["payload_weights"].arrayValue.map{$0["kg"].intValue} ]
//
//                    self.characteristicsArray.append(contentsOf: param)
//                    self.characteristicsArray.append(kg)

//                }
//                let arrayCount = json.arrayValue
//                for itm in arrayCount {
//
//                    let p = СharacteristicForCells(json: itm)
//                    self.ff.append(p)
//
//                }
                
                DispatchQueue.main.async {
                    self.reloadData()
                }
            case .failure(let error):
                print(error)
                
            }
        }
    }
}
    // MARK: - UICollectionViewDataSource
    extension HorizontalCell: UICollectionViewDataSource {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            
            return self.characteristicsArray.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? HorizintalViewCell else { return UICollectionViewCell() }
            cell.secondLabel.text = nameParamArray[indexPath.item]
            cell.firstLabel.text = "\(self.characteristicsArray[indexPath.item])"
            return cell
        }
    }
    // MARK: - UICollectionViewDelegateFlowLayout
    extension HorizontalCell: UICollectionViewDelegateFlowLayout {
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            
            if indexPath.item == 0 {
                collectionView.contentInset = UIEdgeInsets(top: 0, left: 32, bottom: 0, right: 0)
                return CGSize(width: 96, height: 96)
            }
            return CGSize(width: 96,
                          height: 96)
        }
    }


// Картинки парсятся из каждого экземпляра рандомно доработать
// Сделать парсинг одного экземпляра!
