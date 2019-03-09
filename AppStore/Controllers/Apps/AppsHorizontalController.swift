//
//  AppsHorizontalController.swift
//  AppStore
//
//  Created by Jony Tucci on 3/9/19.
//  Copyright © 2019 Jony Tucci. All rights reserved.
//

import UIKit

class AppsHorizontalController: BaseCollectionViewController {
	
	//MARK:- Properties
	let appHorizontalCellId = "AppHorizontalCell"
	
	
	//MARK:- Life Cycle
	override func viewDidLoad() {
		super.viewDidLoad()
		collectionView?.backgroundColor = .blue
		collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: appHorizontalCellId)
		
		if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
			layout.scrollDirection = .horizontal
		}
	}
	
	//MARK:- Collection View Delegate
	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 10
	}
	
	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: appHorizontalCellId, for: indexPath)
		cell.backgroundColor = .red
		return cell
	}
	
	
}

//MARK:- Collection View Flow Layout Delegate
extension AppsHorizontalController: UICollectionViewDelegateFlowLayout {
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		let height = (view.frame.height - 24 - 20) / 3
		return CGSize(width: view.frame.width, height: height)
		
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		return 10
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		return .init(top: 12, left: 16, bottom: 12, right: 16)
	}
	
}
