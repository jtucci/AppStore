//
//  BaseTabBarController.swift
//  AppStore
//
//  Created by Jony Tucci on 3/8/19.
//  Copyright © 2019 Jony Tucci. All rights reserved.
//

import UIKit

class BaseTabBarController: UITabBarController {
	
	//MARK:- Life Cycle
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupViewControllers()
	}
	
	//MARK:- Setup
	private func setupViewControllers() {
		
		viewControllers = [
			generateNavigationController(with: UIViewController(), title: "Today", image: #imageLiteral(resourceName: "today_icon")),
			generateNavigationController(with: UIViewController(), title: "Apps", image: #imageLiteral(resourceName: "apps")),
			generateNavigationController(with: UIViewController(), title: "Search", image: #imageLiteral(resourceName: "search"))
		]
		
	}
	
	
	//MARK:- Helpers
	// Generates view controller wrapped in navigation controller
	private func generateNavigationController(with rootViewController: UIViewController, title: String, image:UIImage) -> UIViewController {
		
		let navController = UINavigationController(rootViewController: rootViewController)
		
		rootViewController.navigationItem.title = title
		rootViewController.view.backgroundColor = .white
		navController.tabBarItem.title = title
		navController.tabBarItem.image = image
		
		navController.navigationBar.prefersLargeTitles = true
		
		return navController
	}
}
