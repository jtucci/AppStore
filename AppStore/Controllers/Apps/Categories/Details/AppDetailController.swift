//
//  AppDetailController.swift
//  AppStore
//
//  Created by Jony Tucci on 3/10/19.
//  Copyright © 2019 Jony Tucci. All rights reserved.
//

import UIKit


final class AppDetailController: BaseCollectionViewController {
	
	//MARK:- Properties
	let topDetailCellId = "topDetailCell"
	let previewDetailCellId = "previewDetailCellId"
	let reviewCellId = "reviewCellId"
	
	var app: Result?
	var reviews: Reviews?
	
	// dependency
	fileprivate let appId: String		
	
	//MARK:- Initialization
	// dependency injection
	init(appId: String) {		
		self.appId = appId
		super.init()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	//MARK:- Life Cycle
	override func viewDidLoad() {
		super.viewDidLoad()
		navigationItem.largeTitleDisplayMode = .never
		setupCollectionView()
		fetchData()
	}
	
	//MARK:- setup
	private func setupCollectionView() {
		collectionView?.backgroundColor = .white
		
		//Top Cell (icon, name, description, price)
		collectionView?.register(AppDetailCell.self, forCellWithReuseIdentifier: topDetailCellId)
		
		//Preview Row cell
		collectionView?.register(PreviewRowCell.self, forCellWithReuseIdentifier: previewDetailCellId)
		
		// Review Row Cell
		collectionView?.register(ReviewRowCell.self, forCellWithReuseIdentifier: reviewCellId)
		
	}
	
	private func fetchData() {
		// Retrieves app info (name, price, preview images)
		let urlString = "https://itunes.apple.com/lookup?id=\(appId)"
		APIService.shared.fetch(urlString: urlString) { (result: SearchResult?, error) in
			let app = result?.results.first
			self.app = app
			DispatchQueue.main.async {
				self.collectionView?.reloadData()
			}
		}
		
		// Retrieves app reviews
		let reviewsUrl = "https://itunes.apple.com/rss/customerreviews/page=1/id=\(appId)/sortby=mostrecent/json?l=en&cc=us"
		APIService.shared.fetch(urlString: reviewsUrl) { (reviews: Reviews?, error) in
			if let error = error {
				print("Could not fetch app reviews: ", error)
				return
			}
			
			self.reviews = reviews
			DispatchQueue.main.async {
				self.collectionView?.reloadData()
			}
		}
	}
	
	//MARK:- Collection View Data Source
	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 3
	}
	
	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
		if indexPath.item == 0 {
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: topDetailCellId, for: indexPath) as! AppDetailCell
			cell.app = app
			return cell
		} else if indexPath.item == 1{
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: previewDetailCellId, for: indexPath) as! PreviewRowCell
			cell.horizontalController.app = self.app
			return cell
		} else {
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reviewCellId, for: indexPath) as! ReviewRowCell
			cell.reviewsController.reviews = self.reviews
			return cell
		}
		

	}
}

//MARK:- Collection View Layout
extension AppDetailController: UICollectionViewDelegateFlowLayout {
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		
		var height: CGFloat = 280
		
		// Autosizes cell
		if indexPath.item == 0 {
			let stubCell = AppDetailCell(frame: .init(x: 0, y: 0, width: view.frame.width, height: 1000))
			stubCell.app = app
			stubCell.layoutIfNeeded()
			let estimatedSize = stubCell.systemLayoutSizeFitting(.init(width: view.frame.width, height: 1000))		
			height = estimatedSize.height
		} else if indexPath.item == 1{
			height = 500
		} else {
			height = 280
		}
		
		return .init(width: view.frame.width, height: height)
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		return .init(top: 0, left: 0, bottom: 16, right: 0)
	}
	
}

