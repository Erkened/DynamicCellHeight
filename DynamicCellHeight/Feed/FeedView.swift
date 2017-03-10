//
//  FeedView.swift
//  DynamicCellHeight
//
//  Created by John Neumann on 09/03/2017.
//  Copyright © 2017 Audioy. All rights reserved.
//

import UIKit

class FeedView: UIView {
    
    fileprivate var cellWidth: CGFloat{
        return frame.size.width
    }

    private lazy var listFlowLayout:ListFlowLayout = {
        let listFlowLayout = ListFlowLayout()
        listFlowLayout.estimatedItemSize = listFlowLayout.itemSize // Give your layout an estimated item size with a decent size. Here we pass the default itemSize
        return listFlowLayout
    }()
    
    // UI
    fileprivate lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.listFlowLayout)
        collectionView.register(FeedCell.self) // register => Extensions.swift
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.white
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        addSubviewsAndSetupContraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FeedView: AutoLayoutType{
    func addSubviewsAndSetupContraints(){
        
        addSubview(collectionView)
        
        // useAndActivate => Extensions.swift
        NSLayoutConstraint.useAndActivate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
    }
}

extension FeedView: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selected cell at row ", indexPath.row)
    }
}

extension FeedView: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: FeedCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        
        var model = FeedCellViewModel(title: "Drink more water", image: UIImage(named: "Image1.jpg")!)
        switch true{
        case indexPath.row % 5 == 0:
            model = FeedCellViewModel(title: "Weekends are the best\nAren't they?", image: UIImage(named: "Image5.png")!)
            break
        case indexPath.row % 4 == 0:
            model = FeedCellViewModel(title: "Strawberries", image: UIImage(named: "Image4.jpg")!)
            break
        case indexPath.row % 3 == 0:
            model = FeedCellViewModel(title: "At the arcade", image: UIImage(named: "Image3.jpg")!)
            break
        case indexPath.row % 2 == 0:
            model = FeedCellViewModel(title: "Eggs", image: UIImage(named: "Image2.jpg")!)
            break
        default:
            break
        }
        
        cell.configure(model: model, cellWidth: cellWidth)
        
        return cell
    }
}
