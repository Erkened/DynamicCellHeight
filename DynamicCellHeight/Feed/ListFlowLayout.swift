//
//  ListFlowLayout.swift
//  DynamicCellHeight
//
//  Created by John Neumann on 09/03/2017.
//  Copyright © 2017 Audioy. All rights reserved.
//

import UIKit

class ListFlowLayout: UICollectionViewFlowLayout {
    
    override init() {
        super.init()
        //setupLayout() // Uncomment to set up your own layout.
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // The layout attribute for each cell
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = super.layoutAttributesForItem(at: indexPath)?.copy() as? UICollectionViewLayoutAttributes
        guard let collectionView = collectionView else { return attributes }
        attributes?.bounds.size.width = collectionView.bounds.width - sectionInset.left - sectionInset.right
        return attributes
    }
    
    // The layout attribute for the visible rect
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let allAttributes = super.layoutAttributesForElements(in: rect)
        return allAttributes?.flatMap({ attributes in
            switch attributes.representedElementCategory{
            case .cell: return layoutAttributesForItem(at: attributes.indexPath)
            default: return attributes
            }
        })
    }
    
    // Uncomment to set up your own layout. Otherwise the default layout is used by the system
    /*
    private func setupLayout() {
        minimumInteritemSpacing = 0 // distance between each cell
        minimumLineSpacing = 0 // distance between each row
        scrollDirection = .vertical // use a vertical layout
    }
    */
}
