//
//  ScreenShotCell.swift
//  AppStore
//
//  Created by Jony Tucci on 3/14/19.
//  Copyright © 2019 Jony Tucci. All rights reserved.
//

import UIKit

class ScreenShotCell: UICollectionViewCell {
	
	let imageView = UIImageView(cornerRadius: 12)
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		addSubview(imageView)
		imageView.fillSuperview()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
