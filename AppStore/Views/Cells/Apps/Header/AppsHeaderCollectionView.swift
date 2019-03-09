//
//  AppsPageHeader.swift
//  AppStore
//
//  Created by Jony Tucci on 3/9/19.
//  Copyright © 2019 Jony Tucci. All rights reserved.
//

import UIKit


class AppsHeaderCollectionView: UICollectionReusableView {
	
	//MARK:- Properties 
	let appHeaderHorizontalController = AppsHeaderHorizontalController()
	
	//MARK:- Initialization
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		addSubview(appHeaderHorizontalController.view)
		appHeaderHorizontalController.view.fillSuperview()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}
