//
//  AppsHorizontalController.swift
//  AppStore
//
//  Created by Jony Tucci on 3/9/19.
//  Copyright © 2019 Jony Tucci. All rights reserved.
//

import UIKit

class AppCategoryHorizontalController: BaseCollectionViewController {
	
	//MARK:- Properties
	let appHorizontalCellId = "AppHorizontalCell"
	
	
	//MARK:- Life Cycle
	override func viewDidLoad() {
		super.viewDidLoad()
		collectionView?.backgroundColor = .white
		collectionView?.register(AppCell.self, forCellWithReuseIdentifier: appHorizontalCellId)
		
		if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
			layout.scrollDirection = .horizontal
		}
	}
	
	//MARK:- Collection View Data Source 
	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 10
	}
	
	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: appHorizontalCellId, for: indexPath)
		
		return cell
	}
	
	
}

//MARK:- Collection View Layout
extension AppCategoryHorizontalController: UICollectionViewDelegateFlowLayout {
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		let height = (view.frame.height - 24 - 20) / 3
		return CGSize(width: view.frame.width - 48, height: height)
		
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		return 10
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		return .init(top: 12, left: 16, bottom: 12, right: 16)
	}
	
}