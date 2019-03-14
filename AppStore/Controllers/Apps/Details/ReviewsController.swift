//
//  ReviewsController.swift
//  AppStore
//
//  Created by Jony Tucci on 3/14/19.
//  Copyright © 2019 Jony Tucci. All rights reserved.
//

import UIKit

class ReviewsController: HorizontalSnappingCollectionViewController {
	
	//MARK:- Properties
	let reviewCellId = "reviewCellId"
	var reviews: Reviews? {
		didSet {
			collectionView?.reloadData()
		}
	}
	
	//MARK:- Life Cycle
	override func viewDidLoad() {
		super.viewDidLoad()
		
		collectionView?.register(ReviewCell.self, forCellWithReuseIdentifier: reviewCellId)
		
		collectionView?.backgroundColor = .white
		collectionView?.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
	}
	
	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return reviews?.feed.entry.count ?? 0
	}
	
	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reviewCellId, for: indexPath) as! ReviewCell
		let entry = reviews?.feed.entry[indexPath.item]
		
		cell.titleLabel.text = entry?.title.label
		cell.authorLabel.text = entry?.author.name.label
		cell.bodyLabel.text = entry?.content.label
		for (index, view) in cell.starsStackView.arrangedSubviews.enumerated() {
			if let ratingInt = Int(entry!.rating.label) {
				view.alpha = index >= ratingInt ? 0 : 1
			}
			
		}
		
		return cell
	}
	
}

//MARK:- Collection View Layout
extension ReviewsController: UICollectionViewDelegateFlowLayout {
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		
		return CGSize(width: view.frame.width - 48, height: view.frame.height)
		
	}
	
}
