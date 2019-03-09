//
//  UIImageView+Init.swift
//  AppStore
//
//  Created by Jony Tucci on 3/9/19.
//  Copyright © 2019 Jony Tucci. All rights reserved.
//

import UIKit

extension UIImageView {
	
	convenience init(cornerRadius: CGFloat) {
		self.init(image: nil)
		self.layer.cornerRadius = cornerRadius
		self.clipsToBounds = true
		self.contentMode = .scaleAspectFill
	}
}
