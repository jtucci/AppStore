//
//  HorizontalSnappingController.swift
//  AppStore
//
//  Created by Jony Tucci on 3/10/19.
//  Copyright © 2019 Jony Tucci. All rights reserved.
//

import UIKit

/// Side scorlling collection view with snapping functionality
class HorizontalSnappingCollectionViewController: UICollectionViewController {
	
	init() {
		let layout = SnappingCollectionViewFlowLayout()
		layout.scrollDirection = .horizontal
		super.init(collectionViewLayout: layout)
		collectionView?.decelerationRate = UIScrollView.DecelerationRate.fast
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

