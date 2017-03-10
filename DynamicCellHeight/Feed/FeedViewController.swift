//
//  FeedViewController.swift
//  DynamicCellHeight
//
//  Created by John Neumann on 09/03/2017.
//  Copyright © 2017 Audioy. All rights reserved.
//

import UIKit

// This view controller is loaded as the root view controller of the navigationController in AppDelegate

class FeedViewController: UIViewController {
    
    private lazy var feedView: FeedView = FeedView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func loadView() {
        view = feedView
    }
}
