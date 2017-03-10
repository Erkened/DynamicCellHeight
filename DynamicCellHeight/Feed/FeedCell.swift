//
//  FeedCell.swift
//  DynamicCellHeight
//
//  Created by John Neumann on 09/03/2017.
//  Copyright © 2017 Audioy. All rights reserved.
//

import UIKit

class FeedCell: UICollectionViewCell {
    
    // Vars
    fileprivate var imageHeightConstraint: NSLayoutConstraint!
    fileprivate var imageHeight: CGFloat = 0{
        didSet{
            layoutIfNeeded() // Lay out in case any more calculations are still ongoing
            imageHeightConstraint.constant = imageHeight // Set the new constant
            layoutIfNeeded() // Wrap in a block if you want to animate the change
        }
    }
    
    // UI
    fileprivate lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        return titleLabel
    }()
    
    fileprivate lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.setContentCompressionResistancePriority(250, for: UILayoutConstraintAxis.vertical)
        imageView.setContentHuggingPriority(250, for: UILayoutConstraintAxis.vertical)
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.orange
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        imageHeightConstraint = imageView.heightAnchor.constraint(lessThanOrEqualToConstant: imageHeight) // Less than or equal is required to make sure that imageview takes the least space possible once UILayoutFittingCompressedSize is called
        addSubviewsAndSetupContraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(model: FeedCellType, cellWidth: CGFloat){
        // Set the variables from our viewModel
        titleLabel.text = model.title
        imageView.image = model.image
        
        // Resize the image to fit exactly the cellWidth with the right ratio. This will automatically update the height constraint
        let ratio = model.image.size.height/model.image.size.width
        imageHeight = cellWidth * ratio
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        
        // Make sure all the calculations are done and the UI is laid out
        self.setNeedsLayout()
        self.layoutIfNeeded()
        
        // Calculate the smallest height required that fits the cell content. The width is set in ListFlowLayout.swift
        layoutAttributes.bounds.size.height = contentView.systemLayoutSizeFitting(UILayoutFittingCompressedSize).height
        return layoutAttributes
    }
}

extension FeedCell: AutoLayoutType{
    func addSubviewsAndSetupContraints(){
        contentView.addSubview(titleLabel)
        contentView.addSubview(imageView)
        
        NSLayoutConstraint.useAndActivate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor), // Set the topAnchor
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
            ])
        
        NSLayoutConstraint.useAndActivate([
            imageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor), // Set the bottomAnchor
            imageHeightConstraint // Set the image height
            ])
    }
}
