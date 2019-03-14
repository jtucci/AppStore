//
//  ReviewRowCell.swift
//  AppStore
//
//  Created by Jony Tucci on 3/14/19.
//  Copyright © 2019 Jony Tucci. All rights reserved.
//

import UIKit

/// Container for collection of review cells
final class ReviewRowCell: UICollectionViewCell {
	
	//MARK:- Properties
	let reviewsController = ReviewsController()
		
	//MARK: - Initialization
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupLayout()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	//MARK:- Setup
	private func setupLayout() {
		addSubview(reviewsController.view)
		reviewsController.view.fillSuperview()
	}
	
}
