//
//  FeedCellViewModel.swift
//  DynamicCellHeight
//
//  Created by John Neumann on 09/03/2017.
//  Copyright © 2017 Audioy. All rights reserved.
//

import Foundation
import UIKit

protocol FeedCellType{
    var title: String {get}
    var image: UIImage {get}
}

struct FeedCellViewModel: FeedCellType{
    let title: String
    let image: UIImage
}
