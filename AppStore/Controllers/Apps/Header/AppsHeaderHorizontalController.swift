//
//  AppsHeaderHorizontalController.swift
//  AppStore
//
//  Created by Jony Tucci on 3/9/19.
//  Copyright © 2019 Jony Tucci. All rights reserved.
//

import UIKit

class AppsHeaderHorizontalController: HorizontalSnappingCollectionViewController {
	
	//MARK:- Properties
	let cellId = "CellId"
	
	var socialApps = [SocialApp]()
	
	//MARK:- Life Cycle
	override func viewDidLoad() {
		super.viewDidLoad()
		collectionView?.backgroundColor = .white
		
		collectionView?.register(AppsHeaderCell.self, forCellWithReuseIdentifier: cellId)
		collectionView?.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
	}
	
	
	//MARK:- Collection View Data Source
	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return socialApps.count 
	}
	
	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AppsHeaderCell
		let app = self.socialApps[indexPath.item]
		
		cell.companyLabel.text = app.name
		cell.titleLabel.text = app.tagline
		cell.imageView.sd_setImage(with: URL(string: app.imageUrl))
		return cell
	}
}


//Mark:- Collection View Layout
extension AppsHeaderHorizontalController: UICollectionViewDelegateFlowLayout {
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

		return CGSize(width: view.frame.width - 48, height: view.frame.height)
		
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		return .init(top: 0, left: 16 , bottom: 0, right: 16)
	}
	
}
