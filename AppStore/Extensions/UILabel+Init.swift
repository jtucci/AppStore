//
//  UILabel+Init.swift
//  AppStore
//
//  Created by Jony Tucci on 3/9/19.
//  Copyright © 2019 Jony Tucci. All rights reserved.
//

import UIKit

extension UILabel {
	
	convenience init(text: String, font: UIFont, numberOfLines: Int = 1) {
		self.init(frame: .zero)
		self.text = text
		self.font = font
		self.numberOfLines = numberOfLines
	}
	
}
