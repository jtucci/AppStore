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
	
	var editorsChoiceGames: AppCategory?
	
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
		APIService.shared.fetchGames { (appCategory, error) in
			if let error = error {
				print("Failed to fetch games: ", error)
				return
			}
			
			self.editorsChoiceGames = appCategory
			DispatchQueue.main.async {
				self.collectionView?.reloadData()
			}//END DispatchQueue
			
		}//END APIService
		
	}//END fetchDAta
	
	
	//MARK:- Collection View Data Source
	// Header cell
	override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
		
		let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerCellId, for: indexPath)
		
		return header
	}
	
	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: appGroupCell, for: indexPath) as! AppCategoryCell
		
		cell.titleLabel.text = editorsChoiceGames?.feed.title
		cell.horizontalController.appCategory = editorsChoiceGames
		cell.horizontalController.collectionView?.reloadData()
		return cell
	}
	
	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 1
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
