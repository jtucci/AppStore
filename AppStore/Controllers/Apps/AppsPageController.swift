//
//  AppsController.swift
//  AppStore
//
//  Created by Jony Tucci on 3/9/19.
//  Copyright © 2019 Jony Tucci. All rights reserved.
//

import UIKit

class AppsPageController: BaseCollectionViewController {
	
	//MARK:- Properties
	let appGroupCell = "AppGroupCell"
	let headerCellId = "headerId"
	
	var appCategories = [AppCategory]()
	
	//MARK: - Life Cycle
	override func viewDidLoad() {
		super.viewDidLoad()
		collectionView?.backgroundColor = .white
		
		collectionView?.register(AppCategoryCell.self, forCellWithReuseIdentifier: appGroupCell)
		collectionView?.register(AppsHeaderCollectionView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerCellId)
		
		fetchData()
	}
	
	//MARK:- Network
	private func fetchData() {
		
		
		var group1: AppCategory?
		var group2: AppCategory?
		var group3: AppCategory?
		
		//Used to sync data fetches
		var dispatchGroup = DispatchGroup()
		
		dispatchGroup.enter()
		APIService.shared.fetchGames { (appCategory, error) in
			
			dispatchGroup.leave()
			
			if let error = error {
				print("Failed to fetch games: ", error)
				return
			}
			group1 = appCategory
			
		}//END APIService
		
		dispatchGroup.enter()
		APIService.shared.fetchTopGrossing { (appCategory, error) in
			
			dispatchGroup.leave()
			
			if let error = error {
				print("Failed to fetch games: ", error)
				return
			}
			
			group2 = appCategory
		}//END APIService
		
		dispatchGroup.enter()
		APIService.shared.fetchAppCategory(for: "https://rss.itunes.apple.com/api/v1/us/ios-apps/top-free/all/50/explicit.json") { (appCategory, error) in
			
			dispatchGroup.leave()
			
			if let error = error {
				print("Failed to fetch games: ", error)
				return
			}
			group3 = appCategory
		}//END APIService
		
		//Completion
		dispatchGroup.notify(queue: .main) {
			if let group = group1 {
				self.appCategories.append(group)
			}
			if let group = group2 {
				self.appCategories.append(group)
			}
			if let group = group3 {
				self.appCategories.append(group)
			}
			self.collectionView?.reloadData()
		}
		
	}//END fetchDAta
	
	
	//MARK:- Collection View Data Source
	// Header cell
	override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
		
		let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerCellId, for: indexPath)
		
		return header
	}
	
	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: appGroupCell, for: indexPath) as! AppCategoryCell
		
		let category = appCategories[indexPath.item]
		
		cell.titleLabel.text = category.feed.title
		cell.horizontalController.appCategory = category
		cell.horizontalController.collectionView?.reloadData()
		return cell
	}
	
	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return appCategories.count
	}

}

//MARK:- Collection View Layout
extension AppsPageController: UICollectionViewDelegateFlowLayout {
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		
		return CGSize(width: view.frame.width, height: 300)
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		return .init(top: 16, left: 0, bottom: 0, right: 0)
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
		return CGSize(width: view.frame.width, height: 300)
	}
	
}
