//
//  AppsHorizontalController.swift
//  AppStore
//
//  Created by Jony Tucci on 3/9/19.
//  Copyright © 2019 Jony Tucci. All rights reserved.
//

import UIKit

final class AppCategoryHorizontalController: HorizontalSnappingCollectionViewController {
	
	//MARK:- Properties
	let appHorizontalCellId = "AppHorizontalCell"
	var appCategory: AppCategory?
	var didSelectHandler: ((FeedResult) -> ())?
	
	//MARK:- Life Cycle
	override func viewDidLoad() {
		super.viewDidLoad()
		setupCollectionView()
	}
	
	//MARK:- Setup
	private func setupCollectionView() {
		collectionView?.backgroundColor = .white
		collectionView?.register(AppCell.self, forCellWithReuseIdentifier: appHorizontalCellId)
		collectionView?.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
	}
	
	//MARK:- Collection View Data Source 
	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return appCategory?.feed.results.count ?? 0
	}
	
	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: appHorizontalCellId, for: indexPath) as! AppCell
		
		let app = appCategory?.feed.results[indexPath.item]
		cell.nameLabel.text = app?.name
		cell.companyLabel.text = app?.artistName
		cell.imageView.sd_setImage(with: URL(string: app?.artworkUrl100 ?? ""))
		
		return cell
	}
	
	//MARK:- Collection View Selection
	override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		if let app = appCategory?.feed.results[indexPath.item] {
			didSelectHandler!(app)
		}
		
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
