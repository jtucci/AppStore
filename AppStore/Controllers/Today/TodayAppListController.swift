//
//  TodayAppListController.swift
//  AppStore
//
//  Created by Jony Tucci on 3/18/19.
//  Copyright © 2019 Jony Tucci. All rights reserved.
//

import UIKit

class TodayAppListController: BaseCollectionViewController {
	
	//MARK:- Properties
	private let todayAppCellId = "appCellId"
	var results = [FeedResult]()
	private let spacing: CGFloat = 16
	
	//MARK:- Life Cycle
	override func viewDidLoad() {
		super.viewDidLoad()
		
		collectionView.backgroundColor = .white
		collectionView.isScrollEnabled = false
		collectionView.register(TodayAppCell.self, forCellWithReuseIdentifier: todayAppCellId)
		
		APIService.shared.fetchGames { (appGroup, error) in
			self.results = appGroup?.feed.results ?? []
			
			DispatchQueue.main.async {
				self.collectionView.reloadData()
			}
		}
	}
	
	
	//MARK:- Collection View Data Source
	
	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return min(4, results.count)
	}
	
	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: todayAppCellId, for: indexPath) as! TodayAppCell
		cell.app = results[indexPath.item]
		return cell
	}
}

//MARK:- Collection View Layout
extension TodayAppListController: UICollectionViewDelegateFlowLayout {
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		
		let height: CGFloat = (view.frame.height - 3 * spacing) / 4
		
		return CGSize(width: view.frame.width, height: height)
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		return spacing
	}
}
