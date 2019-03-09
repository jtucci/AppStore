//
//  UIButton+Init.swift
//  AppStore
//
//  Created by Jony Tucci on 3/9/19.
//  Copyright © 2019 Jony Tucci. All rights reserved.
//

import UIKit

extension UIButton {
	convenience init(title: String) {
		self.init(type: .system)
		self.setTitle(title, for: .normal)
	}
}
