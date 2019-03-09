//
//  AppsController.swift
//  AppStore
//
//  Created by Jony Tucci on 3/9/19.
//  Copyright © 2019 Jony Tucci. All rights reserved.
//

import UIKit

class AppsController: BaseCollectionViewController {
	
	//MARK:- Properties
	let appSectionCellId = "AppSectionCell"
	
	
	//MARK: - Life Cycle
	override func viewDidLoad() {
		super.viewDidLoad()
		collectionView?.backgroundColor = . yellow
		
		collectionView?.register(AppsGroupCell.self, forCellWithReuseIdentifier: appSectionCellId)
	}
	
	//MARK:- Collection View Delegate
	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 5
	}
	
	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: appSectionCellId, for: indexPath)
		return cell
	}
	
}

//MARK:- Collection View Flow Layout Delegate
extension AppsController: UICollectionViewDelegateFlowLayout {
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		
		return CGSize(width: view.frame.width, height: 250)
		
	}
	
}
