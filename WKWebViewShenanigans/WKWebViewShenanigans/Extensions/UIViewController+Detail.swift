//
//  UIViewController+Detail.swift
//  WKWebViewShenanigans
//
//  Created by Ellen Shapiro on 1/15/19.
//  Copyright © 2019 Designated Nerd Software. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func getExistingDetailVC(from splitVC: UISplitViewController) -> DetailViewController {
        guard
            let detailNav = splitVC.viewControllers.last as? UINavigationController,
            let detail = detailNav.topViewController as? DetailViewController else {
                fatalError("Couldn't grab detail from split VC!")
        }
        
        return detail
    }
    
    func replaceExistingDetailVC(in splitVC: UISplitViewController, with detailVC: DetailViewController) {
        guard let detailNav = splitVC.viewControllers.last as? UINavigationController else {
            assertionFailure("Couldn't replace detail VC in split VC!")
            return
        }
        
        detailNav.viewControllers = [detailVC]
    }
    
    func loadNewDetailVC() -> DetailViewController {
        guard let detail = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: DetailViewController.self)) as? DetailViewController else {
            fatalError("Couldn't load detail directly from storyboard!")
        }
        
        return detail
    }
}
