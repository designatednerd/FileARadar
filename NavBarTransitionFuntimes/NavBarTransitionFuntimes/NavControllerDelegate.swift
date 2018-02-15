//
//  NavControllerDelegate.swift
//  NavBarTransitionFuntimes
//
//  Created by Ellen Shapiro (Work) on 2/15/18.
//  Copyright © 2018 Designated Nerd. All rights reserved.
//

import UIKit

class NavControllerDelegate: NSObject, UINavigationControllerDelegate {

    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if viewController is MasterViewController {
            navigationController.navigationBar.barTintColor = .green
            navigationController.navigationBar.tintColor = .white
            navigationController.navigationBar.titleTextAttributes = [ NSAttributedStringKey.foregroundColor : UIColor.white]
            navigationController.navigationBar.shadowImage = UIImage()
        } else {
            navigationController.navigationBar.barTintColor = nil
            navigationController.navigationBar.tintColor = .green
            navigationController.navigationBar.titleTextAttributes = [ NSAttributedStringKey.foregroundColor : UIColor.green]
            navigationController.navigationBar.shadowImage = nil
        }
    }
}
