//
//  PreviewScreenShotsHorizontalController.swift
//  AppStore
//
//  Created by Jony Tucci on 3/13/19.
//  Copyright © 2019 Jony Tucci. All rights reserved.
//

import UIKit

class PreviewScreenShotsHorizontalController: HorizontalSnappingCollectionViewController {
	
	let screenShotCellId = "screenShotCell"
	var app: Result? {
		didSet {
			collectionView?.reloadData()
		}
	}
	
	class ScreenShotCell: UICollectionViewCell {
		
		let imageView = UIImageView(cornerRadius: 12)
		
		override init(frame: CGRect) {
			super.init(frame: frame)
			addSubview(imageView)
			imageView.fillSuperview()
		}
		
		required init?(coder aDecoder: NSCoder) {
			fatalError("init(coder:) has not been implemented")
		}
	}
	
	//MARK:- Life Cycle
	override func viewDidLoad() {
		collectionView?.backgroundColor = .white
		collectionView?.register(ScreenShotCell.self, forCellWithReuseIdentifier: screenShotCellId)
		collectionView?.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
	}
	
	
	//MARK:- Collection View Data Source
	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return app?.screenshotUrls.count ?? 0
	}
	
	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: screenShotCellId, for: indexPath) as! ScreenShotCell
		let screenShotUrl = self.app?.screenshotUrls[indexPath.item] ?? ""
		cell.imageView.sd_setImage(with: URL(string: screenShotUrl) )
		return cell
	}
	
}

//MARK:- Collection View Layout
extension PreviewScreenShotsHorizontalController: UICollectionViewDelegateFlowLayout {
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		
		return CGSize(width: 250, height: view.frame.height)
		
	}
	
//	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//		return 10
//	}
//
//	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//		return .init(top: 12, left: 16, bottom: 12, right: 16)
//	}
	
}

