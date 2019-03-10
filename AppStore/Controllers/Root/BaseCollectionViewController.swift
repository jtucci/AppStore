//
//  BaseCollectionViewController.swift
//  AppStore
//
//  Created by Jony Tucci on 3/9/19.
//  Copyright © 2019 Jony Tucci. All rights reserved.
//

import UIKit

/// Provides default init methods which prevents duplicate boiler plate code
class BaseCollectionViewController: UICollectionViewController {
	
	//MARK:- Initialization
	init() {
		super.init(collectionViewLayout: UICollectionViewFlowLayout())
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}
