//
//  TodayCell.swift
//  AppStore
//
//  Created by Jony Tucci on 3/16/19.
//  Copyright © 2019 Jony Tucci. All rights reserved.
//

import UIKit

class TodayCell: UICollectionViewCell {
	
	//MARK:- Properties
	let imageView = UIImageView(image: #imageLiteral(resourceName: "garden"))
	
	//MARK:- Initialization
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		backgroundColor = .white
		layer.cornerRadius = 16
		addSubview(imageView)
		imageView.contentMode = .scaleAspectFill
		imageView.centerInSuperview(size: .init(width: 250, height: 250))
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
}
