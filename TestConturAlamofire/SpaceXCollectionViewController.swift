//
//  SpaceXCollectionViewController.swift
//  TestConturAlamofire
//
//  Created by Кирилл Демьянцев on 29.10.2022.
//

import UIKit
import SnapKit

private let reuseIdentifier = "Cell"

class SpaceXCollectionViewController: UICollectionViewController {
    
    var rockets: [RocketInfo] = []
    
    
    private let pageControl: UIPageControl = {
        var pc = UIPageControl()
        pc.translatesAutoresizingMaskIntoConstraints = false
        pc.numberOfPages = 3
        pc.currentPage = 0
        return pc
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        setupConstraint()
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        
        //self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        
    }
    
    func setupCollectionView() {
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
    }
    
    func setupConstraint() {
        
        view.addSubview(pageControl)
        
        pageControl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollPos = scrollView.contentOffset.x / view.frame.width
        pageControl.currentPage = Int(scrollPos)
    }


    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 0
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 3
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        
        switch indexPath.item {
        case 0:
            cell.backgroundColor = .red
        case 1:
            cell.backgroundColor = .green
        case 2:
            cell.backgroundColor = .orange
        default:
            cell.backgroundColor = .blue
        }
    
        
    
        return cell
    }
}

extension SpaceXCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
