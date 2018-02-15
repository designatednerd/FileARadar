//
//  DetailViewController.swift
//  NavBarTransitionFuntimes
//
//  Created by Ellen Shapiro (Work) on 2/15/18.
//  Copyright © 2018 Designated Nerd. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!


    func configureView() {

    }

    override func viewDidLoad() {
        super.viewDidLoad()

        detailDescriptionLabel.text = """
        If you tap the back button, the nav bar title color does not change at all, and the barTintColor flashes in instead of transitioning in an animated fashion.

        If you swipe back with an interactive transition, the transition works perfectly.

        ¯\\_(ツ)_/¯
        """
    }
}

