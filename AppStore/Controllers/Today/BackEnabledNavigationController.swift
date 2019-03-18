//
//  BackEnabledNavigationController.swift
//  AppStore
//
//  Created by Jony Tucci on 3/18/19.
//  Copyright © 2019 Jony Tucci. All rights reserved.
//

import UIKit

class BackEnabledNavigationController: UINavigationController, UIGestureRecognizerDelegate {
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		self.interactivePopGestureRecognizer?.delegate = self
	}
	
	func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
		return self.viewControllers.count > 1
	}
	
}
