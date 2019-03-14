//
//  ReviewRowCell.swift
//  AppStore
//
//  Created by Jony Tucci on 3/14/19.
//  Copyright © 2019 Jony Tucci. All rights reserved.
//

import UIKit

class ReviewRowCell: UICollectionViewCell {
	
	//MARK:- Properties
	let reviewsController = ReviewsController()
		
	//MARK: - Initialization
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		backgroundColor = .yellow
		addSubview(reviewsController.view)
		reviewsController.view.fillSuperview()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	

}
